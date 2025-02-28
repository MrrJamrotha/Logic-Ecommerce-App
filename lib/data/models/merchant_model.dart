import 'package:foxShop/core/utils/app_format.dart';

class MerchantModel {
  final String id;
  final String storeName;
  final String avatar;
  final String avatarHash;
  final String cover;
  final String coverHash;

  MerchantModel({
    required this.id,
    required this.storeName,
    required this.avatar,
    required this.avatarHash,
    required this.cover,
    required this.coverHash,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: AppFormat.toStr(json['id']),
      storeName: AppFormat.toStr(json['store_name']),
      avatar: AppFormat.toStr(json['avatar']),
      avatarHash: AppFormat.toStr(json['avatar_hash']),
      cover: AppFormat.toStr(json['cover']),
      coverHash: AppFormat.toStr(json['cover_hash']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_name': storeName,
      'avatar': avatar,
      'avatar_hash': avatarHash,
      'cover': cover,
      'cover_hash': coverHash,
    };
  }
}
