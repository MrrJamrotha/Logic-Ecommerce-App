import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/data/models/order_line_model.dart';
import 'package:foxShop/data/models/payment_method_model.dart';

class OrderDetailModel {
  final String id;
  final String paymentMethodId;
  final String documentCode;
  final String subtotal;
  final String totalAmount;
  final String totalCommission;
  final String totalDiscount;
  final String deliveryFee;
  final String orderStatus;
  final String orderDate;
  final PaymentMethodModel paymentMethodModel;
  final AddressModel addressModel;
  final List<OrderLineModel> orderLines;
  final String orderLineCount;
  OrderDetailModel({
    required this.id,
    required this.paymentMethodId,
    required this.documentCode,
    required this.subtotal,
    required this.totalAmount,
    required this.totalCommission,
    required this.totalDiscount,
    required this.deliveryFee,
    required this.orderStatus,
    required this.orderDate,
    required this.paymentMethodModel,
    required this.addressModel,
    required this.orderLines,
    required this.orderLineCount,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: AppFormat.toStr(json['id']),
      paymentMethodId: AppFormat.toStr(json['payment_method_id']),
      documentCode: AppFormat.toStr(json['document_code']),
      subtotal: AppFormat.toStr(json['subtotal']),
      totalAmount: AppFormat.toStr(json['total_amount']),
      totalCommission: AppFormat.toStr(json['total_commission']),
      totalDiscount: AppFormat.toStr(json['total_discount']),
      deliveryFee: AppFormat.toStr(json['delivery_fee']),
      orderStatus: AppFormat.toStr(json['order_status']),
      orderDate: AppFormat.toStr(json['order_date']),
      paymentMethodModel: PaymentMethodModel.fromJson(json['payment_method']),
      addressModel: AddressModel.fromJson(json['address']),
      orderLines: (json['order_lines'] as List<dynamic>)
          .map((line) => OrderLineModel.fromJson(line as Map<String, dynamic>))
          .toList(),
      orderLineCount: AppFormat.toStr(json['order_lines_count']),
    );
  }
}
