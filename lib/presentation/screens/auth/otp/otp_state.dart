import 'package:foxShop/data/models/user_model.dart';

class OtpState {
  final bool isLoading;
  final String? error;
  final String? message;
  final UserModel? user;

  const OtpState({
    this.isLoading = false,
    this.error,
    this.message,
    this.user,
  });

  OtpState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    UserModel? user,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
