import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/category/category_repository_impl.dart';
import 'package:logic_app/presentation/screens/category/category_state.dart';

class CategoryCubit extends HydratedCubit<CategoryState> {
  CategoryCubit() : super(CategoryState(isLoading: true));
  final repos = di.get<CategoryRepositoryImpl>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getCategories().then((response) {
        emit(state.copyWith(records: response.success));
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(stableState.copyWith(isLoading: false));
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    return CategoryState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    return state.toJson();
  }
}
