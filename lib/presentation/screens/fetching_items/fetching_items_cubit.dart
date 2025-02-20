import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/repositories/fetching_item/fetching_item_repository_impl.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';

class FetchingItemsCubit extends Cubit<FetchingItemsState> {
  FetchingItemsCubit()
      : super(FetchingItemsState(
          isLoading: true,
          selectCategoryId: "",
          selectBrandId: "",
        ));
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
    required String categoryId,
    required FetchingType type,
  }) async {
    emit(state.copyWith(selectCategoryId: categoryId));
    await loadInitialData(type: type, parameters: {
      'category_id': categoryId,
    });
  }

  void priceRangeChange(RangeValues values) {
    emit(state.copyWith(rangeValues: values));
  }

  void selectStars(int rating, bool isSelected) {
    final updatedRatings = Map<int, bool>.from(state.selectedRatings ?? {});
    updatedRatings[rating] = isSelected;
    emit(state.copyWith(selectedRatings: updatedRatings));
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
