import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/slide_show_model.dart';

abstract class HomeRepository {
  Future<Result<List<SlideShowModel>, dynamic>> getSlideShow({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<CategoryModel>, dynamic>> getBrowseCategories({
    Map<String, dynamic>? parameters,
  });

  Future<Result<List<BrandModel>, dynamic>> getBrands({
    Map<String, dynamic>? parameters,
  });
}
