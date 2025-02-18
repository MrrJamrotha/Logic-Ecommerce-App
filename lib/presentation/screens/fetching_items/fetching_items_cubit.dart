import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/data/repositories/fetching_item/fetching_item_repository_impl.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';

class FetchingItemsCubit extends Cubit<FetchingItemsState> {
  FetchingItemsCubit()
      : super(FetchingItemsState(
          isLoading: true,
          selectCategoryId: "",
        )) {
    pagingController.addPageRequestListener((pageKey) {
      paginationGetRecommendedData(pageKey, state.selectCategoryId ?? "");
    });
  }
  final repos = di.get<FetchingItemRepositoryImpl>();

  final pagingController = PagingController(firstPageKey: 1);

  Future<void> loadInitialData({
    FetchingType type = FetchingType.recommented,
    String? categoryId,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      switch (type) {
        case FetchingType.recommented:
          paginationGetRecommendedData(1, categoryId ?? "");
          break;
        case FetchingType.baseSeller:
          break;
        case FetchingType.newArrival:
          break;

        case FetchingType.wishlist:
          break;
      }
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> paginationGetRecommendedData(
    int pageKey,
    String categoryId,
  ) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }

      final response = await repos.getRecommendedForYou(
        parameters: {"page": pageKey, 'category_id': categoryId},
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
        lastPage: response.lastPage,
        currentPage: response.currentPage,
      ));
    } catch (error) {
      pagingController.error = error;
      emit(state.copyWith(error: error.toString()));
    }
  }

  void filterByCategory(String categoryId) async {
    emit(state.copyWith(selectCategoryId: categoryId));
    await loadInitialData(
      type: FetchingType.recommented,
      categoryId: categoryId,
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
