import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/price_range_model.dart';
import 'package:logic_app/data/models/product_model.dart';

class ProductByBrandState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductModel>? records;
  final List<CategoryModel>? categories;
  final PriceRangeModel? priceRangeModel;
  final int currentPage;
  final int lastPage;
  final RangeValues? rangeValues;
  final String? selectCategoryId;
  final Map<int, bool>? selectedRatings;
  final List<String>? selectCategoryIds;

  const ProductByBrandState({
    this.isLoading = false,
    this.error,
    this.records,
    this.categories,
    this.priceRangeModel,
    this.currentPage = 1,
    this.lastPage = 1,
    this.rangeValues,
    this.selectCategoryId,
    this.selectedRatings,
    this.selectCategoryIds,
  });

  ProductByBrandState copyWith({
    bool? isLoading,
    String? error,
    List<ProductModel>? records,
    List<CategoryModel>? categories,
    PriceRangeModel? priceRangeModel,
    int? currentPage,
    int? lastPage,
    RangeValues? rangeValues,
    String? selectCategoryId,
    Map<int, bool>? selectedRatings,
    List<String>? selectCategoryIds,
  }) {
    return ProductByBrandState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      categories: categories ?? this.categories,
      priceRangeModel: priceRangeModel ?? this.priceRangeModel,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      rangeValues: rangeValues ?? this.rangeValues,
      selectCategoryId: selectCategoryId ?? this.selectCategoryId,
      selectedRatings: selectedRatings ?? this.selectedRatings,
      selectCategoryIds: selectCategoryIds ?? this.selectCategoryIds,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        records,
        categories,
        priceRangeModel,
        currentPage,
        lastPage,
        rangeValues,
        selectCategoryId,
        selectedRatings,
        selectCategoryIds,
      ];
}
