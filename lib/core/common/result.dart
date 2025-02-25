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
  final String? message;

  Result({
    this.success,
    this.failed,
    this.lastPage = 1,
    this.currentPage = 1,
    this.categories,
    this.brands,
    this.priceRangeModel,
    this.message,
  });

  // ✅ For Success
  factory Result.right(
    T success, {
    String? message,
    int lastPage = 1,
    int currentPage = 1,
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    PriceRangeModel? priceRangeModel,
  }) {
    return Result(
      success: success,
      message: message,
      lastPage: lastPage,
      currentPage: currentPage,
      categories: categories,
      brands: brands,
      priceRangeModel: priceRangeModel,
    );
  }

  // ❌ For Failure
  factory Result.left(
    E failed, {
    String? message,
    int lastPage = 1,
    int currentPage = 1,
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    PriceRangeModel? priceRangeModel,
  }) {
    return Result(
      failed: failed,
      message: message,
      lastPage: lastPage,
      currentPage: currentPage,
      categories: categories,
      brands: brands,
      priceRangeModel: priceRangeModel,
    );
  }

  // ✅ Utility methods for cleaner code
  bool get isRight => success != null;
  bool get isLeft => failed != null;

  // 💡 Similar to Either.fold() - handles both success and failure cases
  R fold<R>(R Function(E) onLeft, R Function(T) onRight) {
    if (isLeft) {
      return onLeft(failed as E);
    } else {
      return onRight(success as T);
    }
  }
}
