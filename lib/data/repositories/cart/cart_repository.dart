import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart'; 
import 'package:foxShop/data/models/product_cart_model.dart';

abstract class CartRepository {
  Future<Result<List<ProductCartModel>, Failure>> getProductCarts({
    Map<String, dynamic>? parameters,
  });

  Future<Result<ProductCartModel, Failure>> addToCart({
    Map<String, dynamic>? parameters,
  });

  Future<Result<ProductCartModel, Failure>> removeFromCart({
    Map<String, dynamic>? parameters,
  });

  Future<Result<dynamic, Failure>> removeAllCart({
    Map<String, dynamic>? parameters,
  });
 
}
