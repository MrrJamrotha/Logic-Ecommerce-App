import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/data/models/product_model.dart';

abstract class ProductByBrandRepository {
  Future<Result<List<ProductModel>, dynamic>> getProductByBrand({
    Map<String, dynamic>? parameters,
  });
}
