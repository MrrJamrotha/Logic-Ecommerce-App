import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';

abstract class WriteReviewRepository {
  Future<Result<dynamic, Failure>> writeReview({
    Map<String, dynamic>? parameters,
  });
}
