import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/repositories/product_by_brand/product_by_brand_repository_impl.dart';
import 'package:logic_app/presentation/screens/product_by_brand/product_by_brand_state.dart';

class ProductByBrandCubit extends Cubit<ProductByBrandState> {
  ProductByBrandCubit() : super(ProductByBrandState(isLoading: true));
  final repos = di.get<ProductByBrandRepositoryImpl>();
  final pagingController = PagingController(firstPageKey: 1);

  Future<void> loadInitialData({
    Map<String, dynamic>? parameters,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await paginationProductByBrand(parameters: parameters);
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> paginationProductByBrand({
    int pageKey = 1,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }

      final response = await repos.getProductByBrand(
        parameters: {"page": pageKey, ...?parameters},
      );

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
        priceRangeModel: response.priceRangeModel,
        rangeValues: RangeValues(
          AppFormat.toDouble(response.priceRangeModel?.minPrice),
          AppFormat.toDouble(response.priceRangeModel?.maxPrice),
        ),
        lastPage: response.lastPage,
        currentPage: response.currentPage,
      ));
    } catch (e) {
      addError(e);
    }
  }

  Future<void> filterProductByCategory(
      {Map<String, dynamic>? parameters}) async {
    emit(state.copyWith(selectCategoryId: parameters?['category_id']));
    await paginationProductByBrand(parameters: parameters);
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
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
