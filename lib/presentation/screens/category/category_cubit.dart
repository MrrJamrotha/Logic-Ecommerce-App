import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/category/category_repository_impl.dart';
import 'package:foxShop/presentation/screens/category/category_state.dart';

class CategoryCubit extends HydratedCubit<CategoryState> {
  CategoryCubit() : super(CategoryState());
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
    final initialData = CategoryState.fromJson(json);
    emit(initialData);
    return CategoryState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    return state.toJson();
  }
}
