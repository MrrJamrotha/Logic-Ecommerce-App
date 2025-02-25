import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/presentation/screens/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(isLoading: true));
  final session = di.get<UserSessionService>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final auth = await session.getUser();
      emit(state.copyWith(userModel: auth));
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> logout() async {
    await session.logout();
  }
}
