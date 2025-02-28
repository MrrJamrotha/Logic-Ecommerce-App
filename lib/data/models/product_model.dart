import 'package:foxShop/core/utils/app_format.dart';

class ProductModel {
  final String id;
  final String averageStar;
  final String name;
  final String name2;
  final String description;
  final String description2;
  final String price;
  final String merchantId;
  final String categoryId;
  final String commissionId;
  final String brandId;
  final bool isPublic;
  final String status;
  final int stockQuantity;
  final String picture;
  final String pictureHash;
  final String totalReviews;
  final bool isPromotion;
  final String newPrice;
  final String discountType;
  final String discountValue;
  final String wishlistId;

  ProductModel({
    required this.id,
    required this.averageStar,
    required this.name,
    required this.name2,
    required this.description,
    required this.description2,
    required this.price,
    required this.merchantId,
    required this.categoryId,
    required this.commissionId,
    required this.brandId,
    required this.isPublic,
    required this.status,
    required this.stockQuantity,
    required this.picture,
    required this.pictureHash,
    required this.totalReviews,
    required this.isPromotion,
    required this.newPrice,
    required this.discountType,
    required this.discountValue,
    required this.wishlistId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: AppFormat.toStr(json['id']),
      averageStar: AppFormat.toStr(json['average_star']),
      name: AppFormat.toStr(json['name']),
      name2: AppFormat.toStr(json['name_2']),
      description: AppFormat.toStr(json['description']),
      description2: AppFormat.toStr(json['description_2']),
      price: AppFormat.toStr(json['price']),
      merchantId: AppFormat.toStr(json['merchant_id']),
      categoryId: AppFormat.toStr(json['category_id']),
      commissionId: AppFormat.toStr(json['commission_id']),
      brandId: AppFormat.toStr(json['brand_id']),
      isPublic: json['is_public'] ?? false,
      status: AppFormat.toStr(json['status']),
      stockQuantity: AppFormat.toInt(json['stock_quantity']),
      picture: AppFormat.toStr(json['picture']),
      pictureHash: AppFormat.toStr(json['picture_hash']),
      totalReviews: AppFormat.toStr(json['total_reviews']),
      isPromotion: json['is_promotion'] ?? false,
      newPrice: AppFormat.toStr(json['new_price']),
      discountType: AppFormat.toStr(json['discount_type']),
      discountValue: AppFormat.toStr(json['discount_value']),
      wishlistId: AppFormat.toStr(json['wishlist_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'average_star': averageStar,
      'name': name,
      'name_2': name2,
      'description': description,
      'description_2': description2,
      'price': price,
      'merchant_id': merchantId,
      'category_id': categoryId,
      'commission_id': commissionId,
      'brand_id': brandId,
      'is_public': isPublic,
      'status': status,
      'stock_quantity': stockQuantity,
      'picture': picture,
      'picture_hash': pictureHash,
      'total_reviews': totalReviews,
      'is_promotion': isPromotion,
      'new_price': newPrice,
      'discount_type': discountType,
      'discount_value': discountValue,
      'wishlist_id': wishlistId,
    };
  }
}
