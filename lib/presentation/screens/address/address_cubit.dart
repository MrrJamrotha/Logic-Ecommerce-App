import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/address_model.dart';
import 'package:logic_app/data/repositories/address/address_repository_impl.dart';
import 'package:logic_app/presentation/screens/address/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressState(isLoading: true)) {
    pagingController.addPageRequestListener((pageKey) {
      paginationData(pageKey: pageKey);
    });
  }
  final repos = di.get<AddressRepositoryImpl>();
  final PagingController<int, AddressModel> pagingController =
      PagingController(firstPageKey: 1);
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await paginationData();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> paginationData({int pageKey = 1}) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }
      await repos.getUserAddress().then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString()));
        }, (success) {
          var records = state.records ?? [];
          final isLastPage = response.currentPage >= response.lastPage;
          if (isLastPage) {
            pagingController.appendLastPage(success);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(records, nextPageKey);
          }
          emit(state.copyWith(
            records: success,
            lastPage: response.lastPage,
            currentPage: response.currentPage,
          ));
        });
      });
    } catch (error) {
      pagingController.error = error;
      addError(error);
    }
  }

  Future<void> insertAddress(AddressModel record) async {
    try {
      var records = state.records ?? [];
      records = [...records, record];

      // Update the PagingController with the new list
      pagingController.itemList = records;

      // Emit the updated state
      emit(state.copyWith(records: records));
    } catch (error) {
      addError(error);
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
