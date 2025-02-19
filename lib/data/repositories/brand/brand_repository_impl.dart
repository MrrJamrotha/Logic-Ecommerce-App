import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/brand/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final _apiClient = di<ApiClient>();
  @override
  Future<Result<List<BrandModel>, dynamic>> getBrands({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getBrands(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }

      final records = (result.data as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
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
