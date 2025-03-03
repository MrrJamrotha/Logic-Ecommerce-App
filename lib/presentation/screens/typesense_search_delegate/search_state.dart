import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foxShop/core/common/product_search_response.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';

class SearchState extends Equatable {
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

  final ProductSearchResponse? productSearchResponse;

  const SearchState({
    this.isLoading = false,
    this.error,
    this.records,
    this.currentPage = 1,
    this.lastPage = 1,
    this.categories,
    this.brands,
    this.selectCategoryId,
    this.priceRangeModel,
    this.rangeValues,
    this.selectedRatings,
    this.selectCategoryIds,
    this.selectBrandIds,
    this.productSearchResponse,
  });

  SearchState copyWith({
    bool? isLoading,
    String? error,
    List<ProductModel>? records,
    int? currentPage,
    int? lastPage,
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    String? selectCategoryId,
    PriceRangeModel? priceRangeModel,
    RangeValues? rangeValues,
    Map<int, bool>? selectedRatings,
    List<String>? selectCategoryIds,
    List<String>? selectBrandIds,
    ProductSearchResponse? productSearchResponse,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      selectCategoryId: selectCategoryId ?? this.selectCategoryId,
      priceRangeModel: priceRangeModel ?? this.priceRangeModel,
      rangeValues: rangeValues ?? this.rangeValues,
      selectedRatings: selectedRatings ?? this.selectedRatings,
      selectCategoryIds: selectCategoryIds ?? this.selectCategoryIds,
      selectBrandIds: selectBrandIds ?? this.selectBrandIds,
      productSearchResponse:
          productSearchResponse ?? this.productSearchResponse,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        records?.map((record) => record.id),
        currentPage,
        lastPage,
        categories?.map((category) => category.id),
        brands?.map((brand) => brand.id),
        selectCategoryId,
        priceRangeModel,
        rangeValues,
        selectedRatings?.values,
        selectCategoryIds,
        selectBrandIds,
        productSearchResponse,
      ];
}
