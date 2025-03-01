import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/data/models/payment_method_model.dart';
import 'package:foxShop/data/models/product_cart_model.dart';

abstract class CheckOutRepository {
  Future<Result<List<PaymentMethodModel>, Failure>> getPaymentMethod({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<AddressModel>, Failure>> getAddress({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductCartModel>, Failure>> getProductCarts({
    Map<String, dynamic>? parameters,
  });
}
