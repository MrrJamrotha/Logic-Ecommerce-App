import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/merchant_model.dart';
import 'package:foxShop/data/models/product_model.dart';

abstract class MerchantRepository {
  Future<Result<List<ProductModel>, Failure>> getProductByMerchant({
    Map<String, dynamic>? parameters,
  });

  Future<Result<MerchantModel, Failure>> getMerchantProfile({
    Map<String, dynamic>? parameters,
  });
}
