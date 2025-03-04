import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/write_review/write_review_repository.dart';

class WriteReviewRepositoryImpl implements WriteReviewRepository {
  final _apiClient = di.get<ApiClient>();

  @override
  Future<Result<dynamic, Failure>> writeReview({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.writeReview(parameters: parameters);
      if (result.statusCode != 200) {
        return Result.left(Failure(result.message));
      }
      return Result.right(result.data, message: result.message);
    } catch (e) {
      return Result.left(Failure(e.toString()));
    }
  }
}
