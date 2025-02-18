import 'package:equatable/equatable.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/product_model.dart';

class FetchingItemsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductModel>? records;
  final int currentPage;
  final int lastPage;
  final List<CategoryModel>? categories;
  final String? selectCategoryId;

  const FetchingItemsState({
    this.isLoading = false,
    this.error,
    this.records,
    this.currentPage = 1,
    this.lastPage = 1,
    this.categories,
    this.selectCategoryId,
  });

  FetchingItemsState copyWith({
    bool? isLoading,
    String? error,
    List<ProductModel>? records,
    int? currentPage,
    int? lastPage,
    List<CategoryModel>? categories,
    String? selectCategoryId,
  }) {
    return FetchingItemsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      categories: categories ?? this.categories,
      selectCategoryId: selectCategoryId ?? this.selectCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        records,
        currentPage,
        lastPage,
        categories,
        selectCategoryId,
      ];
}
