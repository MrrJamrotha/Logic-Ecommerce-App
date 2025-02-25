import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class ProductByCategoryRepository {
  Future<Result<List<ProductModel>, Failure>> getProductByCategory({
    Map<String, dynamic>? parameters,
  });
}
