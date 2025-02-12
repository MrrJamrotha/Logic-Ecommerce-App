import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/home/home_repository_impl.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true));
  final repos = di.get<HomeRepositoryImpl>();

  Future<void> getSlideShow({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      emit(state.copyWith(isLoadingSlideShow: true));
      await repos.getSlideShow(parameters: parameters).then((response) {
        emit(state.copyWith(slideShowModels: response.success));
      });
      emit(state.copyWith(isLoadingSlideShow: false));
    } catch (e) {
      emit(state.copyWith(isLoadingSlideShow: false));
      addError(e);
    }
  }

  Future<void> getBrowseCategories() async {
    try {
      emit(state.copyWith(isLoadingCategory: true));
      await repos.getBrowseCategories().then((response) {
        emit(state.copyWith(categoryModels: response.success));
      });
      emit(state.copyWith(isLoadingCategory: false));
    } catch (e) {
      emit(state.copyWith(isLoadingCategory: false));
      addError(e);
    }
  }

  Future<void> getBrands() async {
    try {
      emit(state.copyWith(isLoadingCategory: true));
      await repos.getBrands().then((response) {
        emit(state.copyWith(brandModels: response.success));
      });
      emit(state.copyWith(isLoadingCategory: false));
    } catch (e) {
      emit(state.copyWith(isLoadingCategory: false));
      addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}
