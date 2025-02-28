import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryModel>, Failure>> getCategories({
    Map<String, dynamic>? parameters,
  });
}
