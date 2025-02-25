import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/merchant_model.dart';
import 'package:logic_app/data/models/product_model.dart';

abstract class MerchantRepository {
  Future<Result<List<ProductModel>, Failure>> getProductByMerchant({
    Map<String, dynamic>? parameters,
  });

  Future<Result<MerchantModel, Failure>> getMerchantProfile({
    Map<String, dynamic>? parameters,
  });
}
