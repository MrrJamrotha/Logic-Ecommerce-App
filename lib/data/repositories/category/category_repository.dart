import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryModel>, dynamic>> getCategories({
    Map<String, dynamic>? parameters,
  });
}
