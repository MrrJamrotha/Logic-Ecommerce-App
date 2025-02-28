import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/models/slide_show_model.dart';

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
