import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';

class ProductByCategoryState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductModel>? records;
  final List<BrandModel>? brands;
  final PriceRangeModel? priceRangeModel;
  final int currentPage;
  final int lastPage;
  final RangeValues? rangeValues;
  final String? selectBrandId;
  final Map<int, bool>? selectedRatings;
  final List<String>? selectBrandIds;

  const ProductByCategoryState({
    this.isLoading = false,
    this.error,
    this.records,
    this.brands,
    this.priceRangeModel,
    this.currentPage = 1,
    this.lastPage = 1,
    this.rangeValues,
    this.selectBrandId,
    this.selectedRatings,
    this.selectBrandIds,
  });

  ProductByCategoryState copyWith({
    bool? isLoading,
    String? error,
    List<ProductModel>? records,
    List<BrandModel>? brands,
    PriceRangeModel? priceRangeModel,
    int? currentPage,
    int? lastPage,
    RangeValues? rangeValues,
    String? selectBrandId,
    Map<int, bool>? selectedRatings,
    List<String>? selectBrandIds,
  }) {
    return ProductByCategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      brands: brands ?? this.brands,
      priceRangeModel: priceRangeModel ?? this.priceRangeModel,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      rangeValues: rangeValues ?? this.rangeValues,
      selectBrandId: selectBrandId ?? this.selectBrandId,
      selectedRatings: selectedRatings ?? this.selectedRatings,
      selectBrandIds: selectBrandIds ?? this.selectBrandIds,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        records,
        brands,
        priceRangeModel,
        currentPage,
        lastPage,
        rangeValues,
        selectBrandId,
        selectedRatings,
        selectBrandIds,
      ];
}
