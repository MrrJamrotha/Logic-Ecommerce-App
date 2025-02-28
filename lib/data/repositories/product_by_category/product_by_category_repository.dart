import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/product_model.dart';

abstract class ProductByCategoryRepository {
  Future<Result<List<ProductModel>, Failure>> getProductByCategory({
    Map<String, dynamic>? parameters,
  });
}
