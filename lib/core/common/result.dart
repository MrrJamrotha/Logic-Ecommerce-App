import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/price_range_model.dart';

class Result<T, E> {
  final T? success;
  final E? failed;
  final int lastPage;
  final int currentPage;
  final List<CategoryModel>? categories;
  final List<BrandModel>? brands;
  final PriceRangeModel? priceRangeModel;

  Result({
    this.success,
    this.failed,
    this.lastPage = 1,
    this.currentPage = 1,
    this.categories,
    this.brands,
    this.priceRangeModel,
  });
}
