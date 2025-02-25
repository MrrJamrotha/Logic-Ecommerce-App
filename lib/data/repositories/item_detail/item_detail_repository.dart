import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/item_detail_model.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class ItemDetailRepository {
  Future<Result<List<ProductModel>, Failure>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  });

  Future<Result<ItemDetailModel, Failure>> getItemDetail({
    Map<String, dynamic>? parameters,
  });
}
