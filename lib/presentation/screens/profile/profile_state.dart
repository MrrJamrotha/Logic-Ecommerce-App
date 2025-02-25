import 'package:logic_app/data/models/user_model.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserModel? userModel;

  const ProfileState({
    this.isLoading = false,
    this.error,
    this.userModel,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserModel? userModel,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userModel: userModel ?? this.userModel,
    );
  }
}
