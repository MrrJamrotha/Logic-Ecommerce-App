import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/brand/brand_repository_impl.dart';
import 'package:foxShop/presentation/screens/brand/brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandState(isLoading: true));
  final repos = di<BrandRepositoryImpl>();
  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getBrands().then((response) {
        emit(state.copyWith(records: response.success));
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
