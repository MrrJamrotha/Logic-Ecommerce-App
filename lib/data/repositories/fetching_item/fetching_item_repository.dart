import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class FetchingItemRepository {
  Future<Result<List<ProductModel>, dynamic>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, dynamic>> getBastSeller({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, dynamic>> getNewArrival({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, dynamic>> getSpacialProduct({
    Map<String, dynamic>? parameters,
  });
}
