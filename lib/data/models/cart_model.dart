import 'package:foxShop/core/utils/app_format.dart';

class CartModel {
  final String id;
  final String userId;
  final String productId;
  final String variantId;
  final String applicationId;
  final String price;
  final String quantity;

  CartModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.variantId,
    required this.applicationId,
    required this.price,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: AppFormat.toStr(json['id']),
      userId: AppFormat.toStr(json['user_id']),
      productId: AppFormat.toStr(json['product_id']),
      variantId: AppFormat.toStr(json['variant_id']),
      applicationId: AppFormat.toStr(json['application_id']),
      price: AppFormat.toStr(json['price']),
      quantity: AppFormat.toStr(json['quantity']),
    );
  }
}
