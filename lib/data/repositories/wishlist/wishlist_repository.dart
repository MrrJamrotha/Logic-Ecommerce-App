import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/models/wishlist_model.dart';

abstract class WishlistRepository {
  Future<Result<WishlistModel, Failure>> addToWishList({
    Map<String, dynamic>? parameters,
  });

  Future<Result<WishlistModel, Failure>> removeFromWishlist({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getMyWishlist({
    Map<String, dynamic>? parameters,
  });
}
