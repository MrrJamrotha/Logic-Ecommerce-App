import 'package:logic_app/core/utils/app_format.dart';

class PictureModel {
  PictureModel({
    required this.id,
    required this.picture,
    required this.pictureHash,
  });

  final String id;
  final String picture;
  final String pictureHash;

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      id: AppFormat.toStr(json["id"]),
      picture: json["picture"] ?? "",
      pictureHash: json["picture_hash"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "picture_hash": pictureHash,
      };
}
