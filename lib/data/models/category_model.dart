import 'package:logic_app/core/utils/app_format.dart';

class CategoryModel {
  final String id;
  final String name;
  final String name2;
  final String picture;
  final String pictureHash;

  CategoryModel({
    required this.id,
    required this.name,
    required this.name2,
    required this.picture,
    required this.pictureHash,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: AppFormat.toStr(json['id'] ?? ""),
      name: AppFormat.toStr(json['name'] ?? ""),
      name2: AppFormat.toStr(json['name2'] ?? ""),
      picture: AppFormat.toStr(json['picture'] ?? ""),
      pictureHash: AppFormat.toStr(json['picture_hash'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name2': name2,
      'picture': picture,
      'picture_hash': pictureHash,
    };
  }
}
