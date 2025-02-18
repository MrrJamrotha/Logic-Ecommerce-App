import 'package:logic_app/data/models/category_model.dart';

class Result<T, E> {
  final T? success;
  final E? failed;
  final int lastPage;
  final int currentPage;
  final List<CategoryModel>? categories;

  Result({
    this.success,
    this.failed,
    this.lastPage = 1,
    this.currentPage = 1,
    this.categories,
  });
}
