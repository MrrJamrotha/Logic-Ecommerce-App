import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/payment_method_model.dart';

class OrderModel {
  final String id;
  final String paymentMethodId;
  final String documentCode;
  final String subtotal;
  final String totalAmount;
  final String totalCommission;
  final String totalDiscount;
  final String deliveryFee;
  final String orderStatus;
  final String orderLinesCount;
  final PaymentMethodModel paymentMethodModel;
  final String orderDate;

  OrderModel({
    required this.id,
    required this.paymentMethodId,
    required this.documentCode,
    required this.subtotal,
    required this.totalAmount,
    required this.totalCommission,
    required this.totalDiscount,
    required this.deliveryFee,
    required this.orderStatus,
    required this.orderLinesCount,
    required this.paymentMethodModel,
    required this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: AppFormat.toStr(json['id']),
      paymentMethodId: AppFormat.toStr(json['payment_method_id']),
      documentCode: AppFormat.toStr(json['document_code']),
      subtotal: AppFormat.toStr(json['subtotal']),
      totalAmount: AppFormat.toStr(json['total_amount']),
      totalCommission: AppFormat.toStr(json['total_commission']),
      totalDiscount: AppFormat.toStr(json['total_discount']),
      deliveryFee: AppFormat.toStr(json['delivery_fee']),
      orderStatus: AppFormat.toStr(json['order_status']),
      orderLinesCount: AppFormat.toStr(json['order_lines_count']),
      paymentMethodModel: PaymentMethodModel.fromJson(json['payment_method']),
      orderDate: AppFormat.toStr(json['order_date']),
    );
  }
}
