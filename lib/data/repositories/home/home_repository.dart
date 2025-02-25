import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/models/slide_show_model.dart';

abstract class HomeRepository {
  Future<Result<List<SlideShowModel>, Failure>> getSlideShow({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<CategoryModel>, Failure>> getBrowseCategories({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<BrandModel>, Failure>> getBrands({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getProductNewArrivals({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getSpacialProduct({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<ProductModel>, Failure>> getProductBastReview({
    Map<String, dynamic>? parameters,
  });
}
