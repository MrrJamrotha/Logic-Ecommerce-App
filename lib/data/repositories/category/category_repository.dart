import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryModel>, Failure>> getCategories({
    Map<String, dynamic>? parameters,
  });
}
