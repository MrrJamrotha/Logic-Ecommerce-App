import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/home/home_repository_impl.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true));
  final repos = di.get<HomeRepositoryImpl>();

  void getSlideShow({
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

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
