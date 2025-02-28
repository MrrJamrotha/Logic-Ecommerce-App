import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/item_detail_price_model.dart';
import 'package:foxShop/data/models/merchant_model.dart';
import 'package:foxShop/data/models/picture_model.dart';
import 'package:foxShop/data/models/review_model.dart';

class ItemDetailModel {
  ItemDetailModel({
    required this.id,
    required this.merchantId,
    required this.brandId,
    required this.name,
    required this.name2,
    required this.description,
    required this.description2,
    required this.price,
    required this.viewCount,
    required this.averageStar,
    required this.pictures,
    required this.reviews,
    required this.itemDetailPrice,
    required this.totalReview,
    required this.merchant,
    required this.itemDetailPictures,
    required this.categoryId,
  });

  final String id;
  final String merchantId;
  final String categoryId;
  final String brandId;
  final String name;
  final String name2;
  final String description;
  final String description2;
  final String price;
  final String viewCount;
  final String averageStar;
  final String totalReview;
  final MerchantModel merchant;
  final List<PictureModel> pictures;
  final List<ReviewModel> reviews;
  final List<ItemDetailPriceModel> itemDetailPrice;
  final List<PictureModel> itemDetailPictures;

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailModel(
      id: AppFormat.toStr(json["id"]),
      merchantId: AppFormat.toStr(json["merchant_id"]),
      brandId: AppFormat.toStr(json["brand_id"]),
      name: json["name"] ?? "",
      name2: json["name_2"] ?? "",
      description: json["description"] ?? "",
      description2: json["description_2"] ?? "",
      price: json["price"] ?? "",
      viewCount: AppFormat.toStr(json["view_count"]),
      averageStar: AppFormat.toStr(json["average_star"]),
      totalReview: AppFormat.toStr(json["total_review"]),
      pictures: json["pictures"] == null
          ? []
          : List<PictureModel>.from(
              json["pictures"]!.map((x) => PictureModel.fromJson(x))),
      reviews: json["reviews"] == null
          ? []
          : List<ReviewModel>.from(
              json["reviews"]!.map((x) => ReviewModel.fromJson(x))),
      itemDetailPrice: json["item_detail_price"] == null
          ? []
          : List<ItemDetailPriceModel>.from(
              json["item_detail_price"]!.map(
                (x) => ItemDetailPriceModel.fromJson(x),
              ),
            ),
      merchant: MerchantModel.fromJson(json["merchant"]),
      itemDetailPictures: json["item_detail_pictures"] == null
          ? []
          : List<PictureModel>.from(json["item_detail_pictures"]!
              .map((x) => PictureModel.fromJson(x))),
      categoryId: AppFormat.toStr(json["category_id"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "merchant_id": merchantId,
        "brand_id": brandId,
        "name": name,
        "name_2": name2,
        "description": description,
        "description_2": description2,
        "price": price,
        "view_count": viewCount,
        "average_star": averageStar,
        "pictures": pictures.map((x) => x.toJson()).toList(),
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "item_detail_price": itemDetailPrice.map((x) => x.toJson()).toList(),
        "merchant": merchant.toJson(),
        "total_review": totalReview,
        "item_detail_pictures":
            itemDetailPictures.map((x) => x.toJson()).toList(),
        "category_id": categoryId,
      };
}
