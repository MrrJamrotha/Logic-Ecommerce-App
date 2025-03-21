import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/picture_model.dart';

class ReviewModel {
  ReviewModel({
    required this.id,
    required this.comment,
    required this.totalStar,
    required this.username,
    required this.avatar,
    required this.avatarHash,
    required this.phoneNumber,
    required this.pictures,
    required this.date,
  });

  final String id;
  final String comment;
  final String totalStar;
  final String username;
  final dynamic avatar;
  final dynamic avatarHash;
  final String phoneNumber;
  final List<PictureModel> pictures;
  final String date;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: AppFormat.toStr(json["id"]),
      comment: json["comment"] ?? "",
      totalStar: AppFormat.toStr(json["total_star"]),
      username: json["username"] ?? "",
      avatar: json["avatar"],
      avatarHash: json["avatar_hash"],
      phoneNumber: json["phone_number"] ?? "",
      pictures: (json["pictures"] as List<dynamic>?)
              ?.map((item) => PictureModel.fromJson(item))
              .toList() ??
          [],
      date: json["date"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "total_star": totalStar,
        "username": username,
        "avatar": avatar,
        "avatar_hash": avatarHash,
        "phone_number": phoneNumber,
        "pictures": pictures.map((x) => x.toJson()).toList(),
      };
}
