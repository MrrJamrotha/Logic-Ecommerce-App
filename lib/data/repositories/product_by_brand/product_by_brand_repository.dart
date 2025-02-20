import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class ProductByBrandRepository {
  Future<Result<List<ProductModel>, dynamic>> getProductByBrand({
    Map<String, dynamic>? parameters,
  });
}
