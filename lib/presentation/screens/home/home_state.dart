import 'package:equatable/equatable.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/models/slide_show_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingSlideShow;
  final bool isLoadingCategory;
  final bool isLoadingBrand;
  final bool isLoadingRecommend;
  final bool isLoadingNewArrival;
  final bool isLoadingBastReview;
  final bool isLoadingSpecialProducts;
  final String? error;
  final List<SlideShowModel>? slideShowModels;
  final List<CategoryModel>? categoryModels;
  final List<BrandModel>? brandModels;
  final List<ProductModel>? recommendProducts;
  final List<ProductModel>? newArrivals;
  final List<ProductModel>? bastReviewProducts;
  final List<ProductModel>? specialProducts;

  const HomeState({
    this.isLoading = false,
    this.isLoadingSlideShow = false,
    this.isLoadingBrand = false,
    this.isLoadingCategory = false,
    this.isLoadingRecommend = false,
    this.isLoadingNewArrival = false,
    this.isLoadingBastReview = false,
    this.isLoadingSpecialProducts = false,
    this.error,
    this.slideShowModels,
    this.categoryModels,
    this.brandModels,
    this.recommendProducts,
    this.newArrivals,
    this.bastReviewProducts,
    this.specialProducts,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingSlideShow,
    bool? isLoadingBrand,
    bool? isLoadingCategory,
    bool? isLoadingRecommend,
    bool? isLoadingNewArrival,
    bool? isLoadingBastReview,
    bool? isLoadingSpecialProducts,
    String? error,
    List<SlideShowModel>? slideShowModels,
    List<CategoryModel>? categoryModels,
    List<BrandModel>? brandModels,
    List<ProductModel>? recommendProducts,
    List<ProductModel>? newArrivals,
    List<ProductModel>? bastReviewProducts,
    List<ProductModel>? specialProducts,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingSlideShow: isLoadingSlideShow ?? this.isLoadingSlideShow,
      isLoadingBrand: isLoadingBrand ?? this.isLoadingBrand,
      isLoadingCategory: isLoadingCategory ?? this.isLoadingCategory,
      isLoadingNewArrival: isLoadingNewArrival ?? this.isLoadingNewArrival,
      isLoadingBastReview: isLoadingBastReview ?? this.isLoadingBastReview,
      isLoadingSpecialProducts:
          isLoadingSpecialProducts ?? this.isLoadingSpecialProducts,
      error: error ?? this.error,
      slideShowModels: slideShowModels ?? this.slideShowModels,
      categoryModels: categoryModels ?? this.categoryModels,
      brandModels: brandModels ?? this.brandModels,
      recommendProducts: recommendProducts ?? this.recommendProducts,
      newArrivals: newArrivals ?? this.newArrivals,
      bastReviewProducts: bastReviewProducts ?? this.bastReviewProducts,
      specialProducts: specialProducts ?? this.specialProducts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingSlideShow,
        isLoadingBrand,
        isLoadingCategory,
        isLoadingNewArrival,
        isLoadingBastReview,
        isLoadingSpecialProducts,
        error,
        slideShowModels,
        categoryModels,
        brandModels,
        recommendProducts,
        newArrivals,
        bastReviewProducts,
        specialProducts,
      ];

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'isLoadingSlideShow': isLoadingSlideShow,
      'isLoadingBrand': isLoadingBrand,
      'isLoadingCategory': isLoadingCategory,
      'isLoadingRecommend': isLoadingRecommend,
      'isLoadingNewArrival': isLoadingNewArrival,
      'isLoadingBastReview': isLoadingBastReview,
      'isLoadingSpecialProducts': isLoadingSpecialProducts,
      'error': error,
      'slide_show': slideShowModels?.map((e) => e.toJson()).toList(),
      'category': categoryModels?.map((e) => e.toJson()).toList(),
      'brand': brandModels?.map((e) => e.toJson()).toList(),
      'recommendProducts': recommendProducts?.map((e) => e.toJson()).toList(),
      'newArrivals': newArrivals?.map((e) => e.toJson()).toList(),
      'bastReviewProducts': bastReviewProducts?.map((e) => e.toJson()).toList(),
      'specialProducts': specialProducts?.map((e) => e.toJson()).toList(),
    };
  }

  static HomeState fromJson(Map<String, dynamic> json) {
    return HomeState(
      isLoading: json['isLoading'] ?? false,
      isLoadingSlideShow: json['isLoadingSlideShow'] ?? false,
      isLoadingBrand: json['isLoadingBrand'] ?? false,
      isLoadingCategory: json['isLoadingCategory'] ?? false,
      isLoadingNewArrival: json['isLoadingNewArrival'] ?? false,
      isLoadingBastReview: json['isLoadingBastReview'] ?? false,
      isLoadingSpecialProducts: json['isLoadingSpecialProducts'] ?? false,
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
      newArrivals: json['newArrivals']
          ?.map((model) => ProductModel.fromJson(model))
          ?.toList(),
      bastReviewProducts: json['bastReviewProducts']
          ?.map((model) => ProductModel.fromJson(model))
          ?.toList(),
      specialProducts: json['specialProducts']
          ?.map((model) => ProductModel.fromJson(model))
          ?.toList(),
    );
  }
}
