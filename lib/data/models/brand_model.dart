import 'package:logic_app/core/utils/app_format.dart';

class BrandModel {
  final String id;
  final String name;
  final String name2;
  final String description;
  final String description2;
  final String picture;
  final String pictureHash;

  BrandModel({
    required this.id,
    required this.name,
    required this.name2,
    required this.description,
    required this.description2,
    required this.picture,
    required this.pictureHash,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: AppFormat.toStr(json['id'] ?? ""),
      name: AppFormat.toStr(json['name'] ?? ""),
      name2: AppFormat.toStr(json['name2'] ?? ""),
      description: AppFormat.toStr(json['description'] ?? ""),
      description2: AppFormat.toStr(json['description2'] ?? ""),
      picture: AppFormat.toStr(json['picture'] ?? ""),
      pictureHash: AppFormat.toStr(json['picture_hash'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name2': name2,
      'description': description,
      'description2': description2,
      'picture': picture,
      'picture_hash': pictureHash,
    };
  }
}
