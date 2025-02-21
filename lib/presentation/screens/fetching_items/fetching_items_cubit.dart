import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/repositories/fetching_item/fetching_item_repository_impl.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';

class FetchingItemsCubit extends Cubit<FetchingItemsState> {
  FetchingItemsCubit({
    FetchingType type = FetchingType.recommented,
    String merchantId = "",
    String categoryId = "",
    String brandId = "",
  }) : super(FetchingItemsState(
          isLoading: true,
          selectCategoryId: "",
          selectCategoryIds: [],
          selectBrandIds: [],
        )) {
    pagingController.addPageRequestListener((pageKey) {
      var ratings = (state.selectedRatings?.keys.toList() ?? []).isNotEmpty
          ? (state.selectedRatings!.keys.toList()..sort()).join(',')
          : '';
      var categories = (state.selectCategoryIds?.toList() ?? []).isNotEmpty
          ? (state.selectCategoryIds!.toList()..sort()).join(',')
          : categoryId;
      var brands = (state.selectBrandIds?.toList() ?? []).isNotEmpty
          ? (state.selectBrandIds!.toList()..sort()).join(',')
          : brandId;
      paginationFetchingProduct(
        pageKey: pageKey,
        parameters: {
          'merchant_id': merchantId,
          'min_price': state.rangeValues?.start ?? "",
          'max_price': state.rangeValues?.end ?? "",
          'rating': ratings,
          'category_id': categories,
          'brand_id': brands,
        },
        type: type,
      );
    });
  }

  final repos = di.get<FetchingItemRepositoryImpl>();

  final pagingController = PagingController(firstPageKey: 1);

  Future<void> loadInitialData({
    FetchingType type = FetchingType.recommented,
    Map<String, dynamic>? parameters,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      paginationFetchingProduct(parameters: parameters, type: type);
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> paginationFetchingProduct({
    int pageKey = 1,
    Map<String, dynamic>? parameters,
    FetchingType type = FetchingType.recommented,
  }) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }
      dynamic response;
      switch (type) {
        case FetchingType.recommented:
          response = await repos.getRecommendedForYou(
            parameters: {"page": pageKey, ...?parameters},
          );
          break;
        case FetchingType.baseSeller:
          response = await repos.getBastSeller(
            parameters: {"page": pageKey, ...?parameters},
          );
          break;
        case FetchingType.newArrival:
          response = await repos.getNewArrival(
            parameters: {"page": pageKey, ...?parameters},
          );
          break;

        case FetchingType.spacialOffers:
          response = await repos.getSpacialProduct(
            parameters: {"page": pageKey, ...?parameters},
          );
          break;

        case FetchingType.relatedProducts:
          response = await repos.getRelatedProduct(
            parameters: {"page": pageKey, ...?parameters},
          );
          break;

        case FetchingType.wishlist:
          break;
      }

      var records = response.success ?? [];
      final isLastPage = response.currentPage >= response.lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(records);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(records, nextPageKey);
      }

      emit(state.copyWith(
        records: response.success,
        categories: response.categories,
        brands: response.brands,
        priceRangeModel: response.priceRangeModel,
        rangeValues: RangeValues(
          AppFormat.toDouble(response.priceRangeModel?.minPrice),
          AppFormat.toDouble(response.priceRangeModel?.maxPrice),
        ),
        lastPage: response.lastPage,
        currentPage: response.currentPage,
      ));
    } catch (error) {
      pagingController.error = error;
      emit(state.copyWith(error: error.toString()));
    }
  }

  void filterByCategory({
    String merchantId = "",
    required String categoryId,
    required FetchingType type,
  }) async {
    emit(state.copyWith(
      selectCategoryId: categoryId,
      selectBrandId: "",
      selectCategoryIds: [],
      selectBrandIds: [],
      selectedRatings: null,
      rangeValues: RangeValues(0, 0),
    ));
    await loadInitialData(type: type, parameters: {
      'category_id': categoryId,
      'merchant_id': merchantId,
      'min_price': '',
      'max_price': '',
      'rating': '',
      'brand_id': '',
    });
  }

  void priceRangeChange(RangeValues values) {
    emit(state.copyWith(rangeValues: values));
  }

  void selectStars(int rating, bool isSelected) {
    final updatedRatings = Map<int, bool>.from(state.selectedRatings ?? {});

    if (isSelected) {
      updatedRatings[rating] = true;
    } else {
      updatedRatings.remove(rating);
    }

    emit(state.copyWith(selectedRatings: updatedRatings));
  }

  Future<void> filterProducts({required FetchingType type}) async {
    try {
      var ratings = (state.selectedRatings?.keys.toList() ?? []).isNotEmpty
          ? (state.selectedRatings!.keys.toList()..sort()).join(',')
          : '';
      var categories = (state.selectCategoryIds?.toList() ?? []).isNotEmpty
          ? (state.selectCategoryIds!.toList()..sort()).join(',')
          : '';
      var brands = (state.selectBrandIds?.toList() ?? []).isNotEmpty
          ? (state.selectBrandIds!.toList()..sort()).join(',')
          : '';
      emit(state.copyWith(selectCategoryId: ""));
      await filter(
        type: type,
        parameters: {
          'min_price': state.rangeValues?.start,
          'max_price': state.rangeValues?.end,
          'rating': ratings,
          'category_id': categories,
          'brand_id': brands,
        },
      );
    } catch (e) {
      addError(e);
    }
  }

  Future<void> filter({
    required FetchingType type,
    Map<String, dynamic>? parameters,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      pagingController.refresh();
      dynamic response;
      switch (type) {
        case FetchingType.recommented:
          response = await repos.getRecommendedForYou(parameters: parameters);
          break;
        case FetchingType.baseSeller:
          response = await repos.getBastSeller(parameters: parameters);
          break;
        case FetchingType.newArrival:
          response = await repos.getNewArrival(parameters: parameters);
          break;

        case FetchingType.spacialOffers:
          response = await repos.getSpacialProduct(parameters: parameters);
          break;

        case FetchingType.relatedProducts:
          response = await repos.getRelatedProduct(parameters: parameters);
          break;

        case FetchingType.wishlist:
          break;
      }

      emit(state.copyWith(
        records: response.success,
        categories: response.categories,
        brands: response.brands,
        priceRangeModel: response.priceRangeModel,
        rangeValues: RangeValues(
          AppFormat.toDouble(response.priceRangeModel?.minPrice),
          AppFormat.toDouble(response.priceRangeModel?.maxPrice),
        ),
        lastPage: response.lastPage,
        currentPage: response.currentPage,
      ));

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(stableState.copyWith(isLoading: false));
      addError(e);
    }
  }

  void selectCategoryIds(String id) {
    if (!(state.selectCategoryIds?.contains(id) ?? false)) {
      emit(
          state.copyWith(selectCategoryIds: [...?state.selectCategoryIds, id]));
    }
  }

  void removeCategoryIds(String id) {
    emit(
      state.copyWith(
        selectCategoryIds:
            state.selectCategoryIds?.where((item) => item != id).toList(),
      ),
    );
  }

  void selectBrandIds(String id) {
    if (!(state.selectBrandIds?.contains(id) ?? false)) {
      emit(state.copyWith(selectBrandIds: [...?state.selectBrandIds, id]));
    }
  }

  void removeBrandIds(String id) {
    emit(
      state.copyWith(
        selectBrandIds:
            state.selectBrandIds?.where((item) => item != id).toList(),
      ),
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
