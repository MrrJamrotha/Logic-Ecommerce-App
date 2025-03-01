import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/cart/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final _apiClient = di.get<ApiClient>();

  @override
  Future<Result<ProductCartModel, Failure>> addToCart({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.addToCart(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final record = ProductCartModel.fromJson(result.data);
      return Result.right(
        record,
        message: result.message,
        subTotal: result.subTotal,
        totalCommission: result.totalCommission,
        totalDiscount: result.totalDiscount,
        totalCart: result.totalCart,
        totalAmount: result.totalAmount,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductCartModel>, Failure>> getProductCarts({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getProductCarts(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      List<ProductCartModel> records = [];
      for (var item in result.data) {
        records.add(ProductCartModel.fromJson(item));
      }
      return Result.right(
        records,
        message: result.message,
        subTotal: result.subTotal,
        totalCommission: result.totalCommission,
        totalDiscount: result.totalDiscount,
        totalCart: result.totalCart,
        totalAmount: result.totalAmount,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<dynamic, Failure>> removeAllCart({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.removeAllCart(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      return Result.right(
        result.data,
        message: result.message,
        subTotal: result.subTotal,
        totalCommission: result.totalCommission,
        totalDiscount: result.totalDiscount,
        totalCart: result.totalCart,
        totalAmount: result.totalAmount,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<ProductCartModel, Failure>> removeFromCart({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.removeFromCart(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final record = ProductCartModel.fromJson(result.data);
      return Result.right(
        record,
        message: result.message,
        subTotal: result.subTotal,
        totalCommission: result.totalCommission,
        totalDiscount: result.totalDiscount,
        totalCart: result.totalCart,
        totalAmount: result.totalAmount,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
