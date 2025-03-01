import 'package:foxShop/core/utils/app_format.dart';

class PaymentMethodModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final String picture;
  final String pictureHash;

  PaymentMethodModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.picture,
    required this.pictureHash,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: AppFormat.toStr(json['id']),
      code: AppFormat.toStr(json['code']),
      name: AppFormat.toStr(json['name']),
      description: AppFormat.toStr(json['description']),
      picture: AppFormat.toStr(json['picture']),
      pictureHash: AppFormat.toStr(json['picture_hash']),
    );
  }
}
