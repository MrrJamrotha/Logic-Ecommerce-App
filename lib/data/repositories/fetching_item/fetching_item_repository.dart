import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class FetchingItemRepository {
  Future<Result<List<ProductModel>, dynamic>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  });


  Future<Result<List<ProductModel>, dynamic>> getProductByCategory({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, dynamic>> getProductByBrand({
    Map<String, dynamic>? parameters,
  });
}
