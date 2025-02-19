import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<CategoryModel>, dynamic>> getCategories({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getBrowseCategories(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result(success: records);
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }
}
