import 'package:foxShop/core/utils/app_format.dart';

class SlideShowModel {
  final String id;
  final String productId;
  final String categoryId;
  final String brandId;
  final String merchantId;
  final String slideType;
  final String displayType;
  final String picture;
  final String pictureHash;

  SlideShowModel({
    required this.id,
    required this.productId,
    required this.categoryId,
    required this.brandId,
    required this.merchantId,
    required this.slideType,
    required this.displayType,
    required this.picture,
    required this.pictureHash,
  });

  factory SlideShowModel.fromJson(Map<String, dynamic> json) {
    return SlideShowModel(
      id: AppFormat.toStr(json['id'] ?? ""),
      productId: AppFormat.toStr(json['product_id'] ?? ""),
      categoryId: AppFormat.toStr(json['category_id'] ?? ""),
      brandId: AppFormat.toStr(json['brand_id'] ?? ""),
      merchantId: AppFormat.toStr(json['merchant_id'] ?? ""),
      slideType: AppFormat.toStr(json['slide_type'] ?? ""),
      displayType: AppFormat.toStr(json['display_type'] ?? ""),
      picture: AppFormat.toStr(json['picture'] ?? ""),
      pictureHash: AppFormat.toStr(json['picture_hash'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'category_id': categoryId,
      'brand_id': brandId,
      'merchant_id': merchantId,
      'slide_type': slideType,
      'display_type': displayType,
      'picture': picture,
      'picture_hash': pictureHash,
    };
  }
}
