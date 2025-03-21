import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';

class FetchingItemsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductModel>? records;
  final int currentPage;
  final int lastPage;
  final List<CategoryModel>? categories;
  final List<BrandModel>? brands;
  final String? selectCategoryId;
  final PriceRangeModel? priceRangeModel;
  final RangeValues? rangeValues;
  final Map<int, bool>? selectedRatings;
  final List<String>? selectCategoryIds;
  final List<String>? selectBrandIds;

  const FetchingItemsState({
    this.isLoading = false,
    this.error,
    this.records,
    this.currentPage = 1,
    this.lastPage = 1,
    this.categories,
    this.selectCategoryId,
    this.brands,
    this.priceRangeModel,
    this.rangeValues,
    this.selectedRatings,
    this.selectBrandIds,
    this.selectCategoryIds,
  });

  FetchingItemsState copyWith({
    bool? isLoading,
    String? error,
    List<ProductModel>? records,
    int? currentPage,
    int? lastPage,
    List<CategoryModel>? categories,
    String? selectCategoryId,
    List<BrandModel>? brands,
    PriceRangeModel? priceRangeModel,
    RangeValues? rangeValues,
    Map<int, bool>? selectedRatings,
    String? selectBrandId,
    List<String>? selectBrandIds,
    List<String>? selectCategoryIds,
  }) {
    return FetchingItemsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      categories: categories ?? this.categories,
      selectCategoryId: selectCategoryId ?? this.selectCategoryId,
      brands: brands ?? this.brands,
      priceRangeModel: priceRangeModel ?? this.priceRangeModel,
      rangeValues: rangeValues ?? this.rangeValues,
      selectedRatings: selectedRatings ?? this.selectedRatings,
      selectBrandIds: selectBrandIds ?? this.selectBrandIds,
      selectCategoryIds: selectCategoryIds ?? this.selectCategoryIds,
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
        brands,
        priceRangeModel,
        rangeValues,
        selectedRatings,
        selectBrandIds,
        selectCategoryIds,
      ];
}
