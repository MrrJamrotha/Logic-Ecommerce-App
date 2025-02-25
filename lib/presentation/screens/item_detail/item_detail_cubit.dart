import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/item_detail/item_detail_repository_impl.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit() : super(ItemDetailState(isLoading: true));
  final repos = di.get<ItemDetailRepositoryImpl>();
  Future<void> loadInitialData({Map<String, dynamic>? parameters}) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getItemDetail(parameters: parameters).then((response) {
        response.fold((failure) {
          emit(state.copyWith(itemDetailModel: null));
        }, (success) {
          emit(state.copyWith(itemDetailModel: response.success));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getRelatedProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      emit(state.copyWith(isLoadingRelatedProduct: true));
      await repos.getRelatedProduct(parameters: parameters).then((response) {
        response.fold((failure) {
          emit(state.copyWith(relatedProducts: []));
        }, (success) {
          emit(state.copyWith(relatedProducts: response.success));
        });
      });
      emit(state.copyWith(isLoadingRelatedProduct: false));
    } catch (e) {
      emit(state.copyWith(isLoadingRelatedProduct: false));
      addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
