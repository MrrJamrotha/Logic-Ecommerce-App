import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class ItemDetailRepository {
  Future<Result<List<ProductModel>, dynamic>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  });
}
