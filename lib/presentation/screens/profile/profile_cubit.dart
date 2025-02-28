import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/service/user_session_service.dart';
import 'package:foxShop/data/repositories/user/user_repository_impl.dart';
import 'package:foxShop/presentation/screens/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(isLoading: true));
  final session = di.get<UserSessionService>();
  final repos = di.get<UserRepositoryImpl>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final auth = await session.getUser();
      if (auth != null) {
        emit(state.copyWith(isLogin: true));
        await getUserProfile();
      }
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> getUserProfile() async {
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getUserProfile().then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString(), isLoading: false));
        }, (success) {
          emit(state.copyWith(userModel: success, isLoading: false));
        });
      });
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      addError(error);
    }
  }

  Future<bool> logout() async {
    try {
      await session.logout();
      emit(state.copyWith(
        isLogin: false,
        userModel: null,
        isLoading: false,
      ));

      return true;
    } catch (error) {
      addError(error);
      return false;
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
