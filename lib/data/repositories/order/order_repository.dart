import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/order_detail_model.dart';
import 'package:foxShop/data/models/order_model.dart';

abstract class OrderRepository {
  Future<Result<List<OrderModel>, Failure>> getMyOrder({
    Map<String, dynamic>? parameters,
  });

  Future<Result<OrderDetailModel, Failure>> getOrderDetail({
    Map<String, dynamic>? parameters,
  });
}
