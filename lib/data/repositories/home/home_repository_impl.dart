import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/slide_show_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/home/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<SlideShowModel>, dynamic>> getSlideShow({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getSlideShow(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }

      final records = (result.data as List<dynamic>).map((item) {
        return SlideShowModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result(success: records);
    } catch (error) {
      throw GenericFailure(error.toString());
    }
  }
}
