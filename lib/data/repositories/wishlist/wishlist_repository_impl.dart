import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/price_range_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/models/wishlist_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/wishlist/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<WishlistModel, Failure>> addToWishList({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.addToWishlist(parameters: parameters);
      if (result.statusCode != 200) {
        return Result.left(Failure(result.message));
      }
      final record = WishlistModel.fromJson(result.data);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getMyWishlist({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getMyWishlist(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<WishlistModel, Failure>> removeFromWishlist({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.removeFromWishlist(parameters: parameters);
      if (result.statusCode != 200) {
        return Result.left(Failure(result.message));
      }
      final record = WishlistModel.fromJson(result.data);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
