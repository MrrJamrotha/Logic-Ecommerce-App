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
        response.fold((failure) {
          emit(state.copyWith(slideShowModels: []));
        }, (success) {
          emit(state.copyWith(slideShowModels: success));
        });
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
        response.fold((failure) {
          emit(state.copyWith(categoryModels: []));
        }, (success) {
          emit(state.copyWith(categoryModels: response.success));
        });
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
        response.fold((failure) {
          emit(state.copyWith(brandModels: []));
        }, (success) {
          emit(state.copyWith(brandModels: response.success));
        });
      });
      emit(state.copyWith(isLoadingCategory: false));
    } catch (e) {
      emit(state.copyWith(isLoadingCategory: false));
      addError(e);
    }
  }

  Future<void> getRecommendedForYou() async {
    try {
      emit(state.copyWith(isLoadingRecommend: true));
      await repos.getRecommendedForYou().then((response) {
        response.fold((failure) {
          emit(state.copyWith(recommendProducts: []));
        }, (success) {
          emit(state.copyWith(recommendProducts: response.success));
        });
      });
      emit(state.copyWith(isLoadingRecommend: false));
    } catch (e) {
      emit(state.copyWith(isLoadingRecommend: false));
      addError(e);
    }
  }

  Future<void> getProductNewArrivals() async {
    try {
      emit(state.copyWith(isLoadingNewArrival: true));
      await repos.getProductNewArrivals().then((response) {
        response.fold((failure) {
          emit(state.copyWith(newArrivals: []));
        }, (success) {
          emit(state.copyWith(newArrivals: success));
        });
      });
      emit(state.copyWith(isLoadingNewArrival: false));
    } catch (e) {
      emit(state.copyWith(isLoadingNewArrival: false));
      addError(e);
    }
  }

  Future<void> getProductBastReview() async {
    try {
      emit(state.copyWith(isLoadingBastReview: true));
      await repos.getProductBastReview().then((response) {
        response.fold((failure) {
          emit(state.copyWith(bastReviewProducts: []));
        }, (success) {
          emit(state.copyWith(bastReviewProducts: success));
        });
      });
      emit(state.copyWith(isLoadingBastReview: false));
    } catch (e) {
      emit(state.copyWith(isLoadingBastReview: false));
      addError(e);
    }
  }

  Future<void> getSpacialProduct() async {
    try {
      emit(state.copyWith(isLoadingSpecialProducts: true));
      await repos.getSpacialProduct().then((response) {
        response.fold((failure) {
          emit(state.copyWith(specialProducts: []));
        }, (success) {
          emit(state.copyWith(specialProducts: success));
        });
      });
      emit(state.copyWith(isLoadingSpecialProducts: false));
    } catch (e) {
      emit(state.copyWith(isLoadingSpecialProducts: false));
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
