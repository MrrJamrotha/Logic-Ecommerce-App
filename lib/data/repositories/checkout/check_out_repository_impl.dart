import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/data/models/payment_method_model.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/checkout/check_out_repository.dart';

class CheckOutRepositoryImpl implements CheckOutRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<PaymentMethodModel>, Failure>> getPaymentMethod({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getPaymentMethod(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return PaymentMethodModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<AddressModel>, Failure>> getAddress({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getAddress();
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      List<AddressModel> records = [];
      for (var address in result.data) {
        records.add(AddressModel.fromJson(address));
      }
      return Result.right(
        records,
        message: result.message,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
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
  Future<Result<AddressModel, Failure>> setDefaultAddress(
      {Map<String, dynamic>? parameters}) async {
    try {
      final result = await _apiClient.setDefaultAddress(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      var record = AddressModel.fromJson(result.data);
      return Result.right(
        record,
        message: result.message,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
