import 'package:foxShop/core/utils/app_format.dart';

class PriceRangeModel {
  final String minPrice;
  final String maxPrice;

  PriceRangeModel({required this.minPrice, required this.maxPrice});

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) {
    return PriceRangeModel(
      minPrice: AppFormat.toStr(json['min_price']),
      maxPrice: AppFormat.toStr(json['max_price']),
    );
  }
}
