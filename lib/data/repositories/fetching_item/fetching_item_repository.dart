import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class FetchingItemRepository {
  Future<Result<List<ProductModel>, Failure>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getBastSeller({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getNewArrival({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getSpacialProduct({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  });
}
