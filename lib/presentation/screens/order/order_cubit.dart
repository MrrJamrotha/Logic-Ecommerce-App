import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/order_model.dart';
import 'package:foxShop/data/repositories/order/order_repository_impl.dart';
import 'package:foxShop/presentation/screens/order/order_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(isLoading: true)) {
    pagingController.addPageRequestListener((pageKey) {});
  }
  final repos = di.get<OrderRepositoryImpl>();
  final PagingController<int, OrderModel> pagingController =
      PagingController(firstPageKey: 1);
  Future<void> loadInitialData({
    int pageKey = 1,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (pageKey == 1) {
        emit(state.copyWith(isLoading: true));
        pagingController.refresh();
      }
      await repos.getMyOrder(parameters: {
        ...?parameters,
        'page': pageKey,
      }).then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.message));
          showMessage(message: failure.message, status: MessageStatus.warning);
        }, (success) {
          var records = success;
          final isLastPage = response.currentPage >= response.lastPage;
          if (isLastPage) {
            pagingController.appendLastPage(records);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(records, nextPageKey);
          }
          emit(state.copyWith(
            records: success,
            lastPage: response.lastPage,
            currentPage: response.currentPage,
            isLoading: false,
          ));
        });
      });

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      pagingController.error = error;
      emit(state.copyWith(
        error: error.toString(),
        isLoading: false,
      ));
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
