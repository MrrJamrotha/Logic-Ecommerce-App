import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/order_detail_model.dart';
import 'package:foxShop/data/models/order_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<OrderModel>, Failure>> getMyOrder({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getMyOrder(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      List<OrderModel> records = [];
      for (var item in result.data) {
        records.add(OrderModel.fromJson(item));
      }
      return Result.right(
        records,
        message: result.message,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<OrderDetailModel, Failure>> getOrderDetail({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getOrderDetail(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      return Result.right(
        result.data,
        message: result.message,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
