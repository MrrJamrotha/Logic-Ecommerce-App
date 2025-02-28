import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/item_detail_model.dart';
import 'package:foxShop/data/models/product_model.dart';

abstract class ItemDetailRepository {
  Future<Result<List<ProductModel>, Failure>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  });

  Future<Result<ItemDetailModel, Failure>> getItemDetail({
    Map<String, dynamic>? parameters,
  });
}
