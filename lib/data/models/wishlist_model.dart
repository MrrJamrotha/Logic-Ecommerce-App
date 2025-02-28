import 'package:logic_app/core/utils/app_format.dart';

class WishlistModel {
  final String id;
  final String productId;
  final String variantId;
  final String userId;

  WishlistModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.userId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: AppFormat.toStr(json['id']),
      productId: AppFormat.toStr(json['product_id']),
      variantId: AppFormat.toStr(json['variant_id']),
      userId: AppFormat.toStr(json['user_id']),
    );
  }
}
