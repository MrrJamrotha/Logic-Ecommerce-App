import 'package:equatable/equatable.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/models/slide_show_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingSlideShow;
  final bool isLoadingCategory;
  final bool isLoadingBrand;
  final bool isLoadingRecommend;
  final String? error;
  final List<SlideShowModel>? slideShowModels;
  final List<CategoryModel>? categoryModels;
  final List<BrandModel>? brandModels;
  final List<ProductModel>? recommendProducts;

  const HomeState({
    this.isLoading = false,
    this.isLoadingSlideShow = false,
    this.isLoadingBrand = false,
    this.isLoadingCategory = false,
    this.isLoadingRecommend = false,
    this.error,
    this.slideShowModels,
    this.categoryModels,
    this.brandModels,
    this.recommendProducts,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingSlideShow,
    bool? isLoadingBrand,
    bool? isLoadingCategory,
    bool? isLoadingRecommend,
    String? error,
    List<SlideShowModel>? slideShowModels,
    List<CategoryModel>? categoryModels,
    List<BrandModel>? brandModels,
    List<ProductModel>? recommendProducts,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingSlideShow: isLoadingSlideShow ?? this.isLoadingSlideShow,
      isLoadingBrand: isLoadingBrand ?? this.isLoadingBrand,
      isLoadingCategory: isLoadingCategory ?? this.isLoadingCategory,
      error: error ?? this.error,
      slideShowModels: slideShowModels ?? this.slideShowModels,
      categoryModels: categoryModels ?? this.categoryModels,
      brandModels: brandModels ?? this.brandModels,
      recommendProducts: recommendProducts ?? this.recommendProducts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingSlideShow,
        isLoadingBrand,
        isLoadingCategory,
        error,
        slideShowModels,
        categoryModels,
        brandModels,
        recommendProducts,
      ];

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'isLoadingSlideShow': isLoadingSlideShow,
      'isLoadingBrand': isLoadingBrand,
      'isLoadingCategory': isLoadingCategory,
      'isLoadingRecommend': isLoadingRecommend,
      'error': error,
      'slide_show': slideShowModels?.map((e) => e.toJson()).toList(),
      'category': categoryModels?.map((e) => e.toJson()).toList(),
      'brand': brandModels?.map((e) => e.toJson()).toList(),
      'recommendProducts': recommendProducts?.map((e) => e.toJson()).toList(),
    };
  }

  static HomeState fromJson(Map<String, dynamic> json) {
    return HomeState(
      isLoading: json['isLoading'] ?? false,
      isLoadingSlideShow: json['isLoadingSlideShow'] ?? false,
      isLoadingBrand: json['isLoadingBrand'] ?? false,
      isLoadingCategory: json['isLoadingCategory'] ?? false,
      error: json['error'],
      slideShowModels: json['slide_show']
          ?.map((model) => SlideShowModel.fromJson(model))
          ?.toList(),
      brandModels:
          json['brand']?.map((model) => BrandModel.fromJson(model))?.toList(),
      categoryModels: json['category']
          ?.map((model) => CategoryModel.fromJson(model))
          ?.toList(),
      recommendProducts: json['recommendProducts']
          ?.map((model) => ProductModel.fromJson(model))
          ?.toList(),
    );
  }
}
