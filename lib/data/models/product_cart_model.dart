import 'package:foxShop/core/utils/app_format.dart';

class ProductCartModel {
  final String id;
  final String variantId;
  final String productId;
  final String colorId;
  final String sizeId;
  final String averageStar;
  final String totalReviews;
  final String discountType;
  final String discountValue;
  final String name;
  final String name2;
  final String description;
  final String colorName;
  final String sizeName;
  final String picture;
  final String pictureHash;
  final String quantity;
  final String price;
  final String newPrice;
  final String subtotal;
  final String totalDiscount;
  final String commissionAmount;
  final String totalAmount;
  final bool isPromotion;

  ProductCartModel({
    required this.id,
    required this.variantId,
    required this.productId,
    required this.colorId,
    required this.sizeId,
    required this.averageStar,
    required this.totalReviews,
    required this.discountType,
    required this.discountValue,
    required this.name,
    required this.name2,
    required this.description,
    required this.colorName,
    required this.sizeName,
    required this.picture,
    required this.pictureHash,
    required this.quantity,
    required this.price,
    required this.newPrice,
    required this.subtotal,
    required this.totalDiscount,
    required this.commissionAmount,
    required this.totalAmount,
    required this.isPromotion,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: AppFormat.toStr(json['id']),
      variantId: AppFormat.toStr(json['variant_id']),
      productId: AppFormat.toStr(json['product_id']),
      colorId: AppFormat.toStr(json['color_id']),
      sizeId: AppFormat.toStr(json['size_id']),
      averageStar: AppFormat.toStr(json['average_star']),
      totalReviews: AppFormat.toStr(json['total_reviews']),
      discountType: AppFormat.toStr(json['discount_type']),
      discountValue: AppFormat.toStr(json['discount_value']),
      name: AppFormat.toStr(json['name']),
      name2: AppFormat.toStr(json['name2']),
      description: AppFormat.toStr(json['description']),
      colorName: AppFormat.toStr(json['color_name']),
      sizeName: AppFormat.toStr(json['size_name']),
      picture: AppFormat.toStr(json['picture']),
      pictureHash: AppFormat.toStr(json['picture_hash']),
      quantity: AppFormat.toStr(json['quantity']),
      price: AppFormat.toStr(json['price']),
      newPrice: AppFormat.toStr(json['new_price']),
      subtotal: AppFormat.toStr(json['subtotal']),
      totalDiscount: AppFormat.toStr(json['total_discount']),
      commissionAmount: AppFormat.toStr(json['commission_amount']),
      totalAmount: AppFormat.toStr(json['total_amount']),
      isPromotion: json['is_promotion'] ?? false,
    );
  }
}
