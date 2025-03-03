import 'package:foxShop/core/utils/app_format.dart';

class OrderLineModel {
  final String id;
  final String status;
  final String productId;
  final String variantId;
  final String price;
  final String quantity;
  final String totalAmount;
  final String totalDiscount;
  final String deliveryFee;
  final String name;
  final String name2;
  final String description;
  final String description2;
  final String picture;
  final String pictureHash;
  final String colorName;
  final String sizeName;
  final bool isPromotion;

  OrderLineModel({
    required this.id,
    required this.status,
    required this.productId,
    required this.variantId,
    required this.price,
    required this.quantity,
    required this.totalAmount,
    required this.totalDiscount,
    required this.deliveryFee,
    required this.name,
    required this.name2,
    required this.description,
    required this.description2,
    required this.picture,
    required this.pictureHash,
    required this.colorName,
    required this.sizeName,
    required this.isPromotion,
  });

  factory OrderLineModel.fromJson(Map<String, dynamic> json) {
    return OrderLineModel(
      id: AppFormat.toStr(json['id']),
      status: AppFormat.toStr(json['status']),
      productId: AppFormat.toStr(json['product_id']),
      variantId: AppFormat.toStr(json['variant_id']),
      price: AppFormat.toStr(json['price']),
      quantity: AppFormat.toStr(json['quantity']),
      totalAmount: AppFormat.toStr(json['total_amount']),
      totalDiscount: AppFormat.toStr(json['total_discount']),
      deliveryFee: AppFormat.toStr(json['delivery_fee']),
      name: AppFormat.toStr(json['name']),
      name2: AppFormat.toStr(json['name_2']),
      description: AppFormat.toStr(json['description']),
      description2: AppFormat.toStr(json['description_2']),
      picture: AppFormat.toStr(json['picture']),
      pictureHash: AppFormat.toStr(json['picture_hash']),
      colorName: AppFormat.toStr(json['color_name']),
      sizeName: AppFormat.toStr(json['size_name']),
      isPromotion: json['is_promotion'] ?? false,
    );
  }
}
