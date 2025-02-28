import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/models/wishlist_model.dart';

class WishlistState extends Equatable {
  final List<ProductModel>? records;
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;
  final List<CategoryModel>? categories;
  final List<BrandModel>? brands;
  final PriceRangeModel? priceRangeModel;
  final int lastPage;
  final int currentPage;
  final RangeValues? rangeValues;
  final Map<int, bool>? selectedRatings;
  final List<String>? selectCategoryIds;
  final List<String>? selectBrandIds;
  final String? selectBrandId;
  final String? selectCategoryId;
  final List<WishlistModel>? wishlists;

  const WishlistState({
    this.records,
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
    this.categories,
    this.brands,
    this.priceRangeModel,
    this.lastPage = 1,
    this.currentPage = 1,
    this.rangeValues,
    this.selectedRatings,
    this.selectCategoryIds,
    this.selectBrandIds,
    this.selectBrandId,
    this.selectCategoryId,
    this.wishlists,
  });

  WishlistState copyWith({
    List<ProductModel>? records,
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    PriceRangeModel? priceRangeModel,
    int? lastPage,
    int? currentPage,
    RangeValues? rangeValues,
    Map<int, bool>? selectedRatings,
    List<String>? selectCategoryIds,
    List<String>? selectBrandIds,
    String? selectBrandId,
    String? selectCategoryId,
    List<WishlistModel>? wishlists,
  }) {
    return WishlistState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      priceRangeModel: priceRangeModel ?? this.priceRangeModel,
      lastPage: lastPage ?? this.lastPage,
      currentPage: currentPage ?? this.currentPage,
      rangeValues: rangeValues ?? this.rangeValues,
      selectedRatings: selectedRatings ?? this.selectedRatings,
      selectCategoryIds: selectCategoryIds ?? this.selectCategoryIds,
      selectBrandIds: selectBrandIds ?? this.selectBrandIds,
      selectBrandId: selectBrandId ?? this.selectBrandId,
      selectCategoryId: selectCategoryId ?? this.selectCategoryId,
      wishlists: wishlists ?? this.wishlists,
    );
  }

  @override
  List<Object?> get props => [
        records,
        isLoading,
        errorMessage,
        isAuthenticated,
        categories,
        brands,
        priceRangeModel,
        lastPage,
        currentPage,
        rangeValues,
        selectedRatings,
        selectCategoryIds,
        selectBrandIds,
        selectBrandId,
        selectCategoryId,
        wishlists,
      ];
}
