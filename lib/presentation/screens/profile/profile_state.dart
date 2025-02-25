import 'package:logic_app/data/models/user_model.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserModel? userModel;
  final bool isLogin;

  const ProfileState({
    this.isLoading = false,
    this.error,
    this.userModel,
    this.isLogin = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserModel? userModel,
    bool? isLogin,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userModel: userModel ?? this.userModel,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
