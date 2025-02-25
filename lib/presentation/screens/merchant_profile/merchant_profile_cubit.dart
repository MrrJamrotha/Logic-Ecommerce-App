import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/repositories/merchant/merchant_repository_impl.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_state.dart';

class MerchantProfileCubit extends Cubit<MerchantProfileState> {
  MerchantProfileCubit() : super(MerchantProfileState(isLoading: true));

  final repos = di.get<MerchantRepositoryImpl>();
  final PagingController<int, ProductModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> loadInitialData({
    Map<String, dynamic>? parameters,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getMerchantProfile(parameters: parameters).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString()));
        }, (success) {
          emit(state.copyWith(record: response.success));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getProductByMerchant({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      emit(state.copyWith(isLoadingProduct: true));
      paginationProduct(pageKey: 1, parameters: parameters);
      emit(state.copyWith(isLoadingProduct: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoadingProduct: false));
    }
  }

  Future<void> paginationProduct({
    Map<String, dynamic>? parameters,
    int pageKey = 1,
  }) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }

      final response = await repos.getProductByMerchant(parameters: {
        "page": pageKey,
        ...?parameters,
      });

      response.fold((failure) {
        emit(state.copyWith(
          error: failure.toString(),
          isLoadingProduct: false,
        ));
      }, (success) {
        var records = response.success ?? [];
        final isLastPage = response.currentPage >= response.lastPage;
        if (isLastPage) {
          pagingController.appendLastPage(records);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(records, nextPageKey);
        }

        emit(state.copyWith(
          products: response.success,
          lastPage: response.lastPage,
          currentPage: response.currentPage,
          isLoadingProduct: false,
        ));
      });
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
