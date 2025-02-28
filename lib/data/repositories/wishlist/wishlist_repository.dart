import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/models/wishlist_model.dart';

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

  Future<Result<List<WishlistModel>, Failure>> getWishlist({
    Map<String, dynamic>? parameters,
  });
}
