import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/common/product_search_response.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/repositories/search/search_repository_impl.dart';
import 'package:foxShop/presentation/screens/typesense_search_delegate/search_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState()) {
    pagingSuggesstionController.addPageRequestListener((pageKey) {
      typesenceProduct(query: "", pageKey: pageKey);
    });
    pagingProductController.addPageRequestListener((pageKey) {
      searchProducts(pageKey: pageKey);
    });
  }
  final repos = di.get<SearchRepositoryImpl>();

  PagingController<int, ProductModel> pagingProductController =
      PagingController(firstPageKey: 1);

  PagingController<int, Hit> pagingSuggesstionController =
      PagingController(firstPageKey: 1);

  Future<void> searchProducts({
    int pageKey = 1,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (pageKey == 1) {
        emit(state.copyWith(isLoading: true));
        pagingProductController.refresh();
      }
      await repos.searchProduct(parameters: {
        ...?parameters,
        'page': pageKey,
      }).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.message));
        }, (success) {
          var records = response.success ?? [];
          final isLastPage = response.currentPage >= response.lastPage;
          if (isLastPage) {
            pagingProductController.appendLastPage(records);
          } else {
            final nextPageKey = pageKey + 1;
            pagingProductController.appendPage(records, nextPageKey);
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
            isLoading: false,
          ));
        });
      });
    } catch (e) {
      addError(e);
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> typesenceProduct({
    int pageKey = 1,
    required String query,
  }) async {
    try {
      if (pageKey == 1) {
        emit(state.copyWith(isLoading: true));
        pagingSuggesstionController.refresh();
      }
      await repos.typesenceProduct(query, page: pageKey).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.message));
        }, (success) {
          final isLastPage =
              success.hits.length < success.requestParams.perPage;
          if (pageKey == 1) {
            pagingSuggesstionController.itemList = success.hits;
          } else {
            pagingSuggesstionController.appendPage(success.hits, pageKey + 1);
          }

          if (isLastPage) {
            pagingSuggesstionController.appendLastPage(success.hits);
          } else {
            pagingSuggesstionController.appendPage(success.hits, pageKey + 1);
          }
          emit(state.copyWith(
            productSearchResponse: ProductSearchResponse(
              facetCounts: success.facetCounts,
              found: success.found,
              hits: success.hits,
              outOf: success.outOf,
              page: success.page,
              requestParams: success.requestParams,
              searchCutoff: success.searchCutoff,
              searchTimeMs: success.searchTimeMs,
            ),
            isLoading: false,
          ));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      addError(e);
      pagingSuggesstionController.error = e;
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  Future<void> close() {
    pagingProductController.dispose();
    return super.close();
  }
}
