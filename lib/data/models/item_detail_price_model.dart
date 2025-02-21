import 'package:logic_app/core/utils/app_format.dart';

class ItemDetailPriceModel {
  ItemDetailPriceModel({
    required this.id,
    required this.name,
    required this.name2,
    required this.description,
    required this.description2,
  });

  final String id;
  final String name;
  final String name2;
  final String description;
  final String description2;

  factory ItemDetailPriceModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailPriceModel(
      id: AppFormat.toStr(json["id"]),
      name: json["name"] ?? "",
      name2: json["name_2"] ?? "",
      description: json["description"] ?? "",
      description2: json["description_2"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_2": name2,
        "description": description,
        "description_2": description2,
      };
}
