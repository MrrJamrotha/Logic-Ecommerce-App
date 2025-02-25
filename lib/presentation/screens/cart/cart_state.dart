import 'package:logic_app/data/models/user_model.dart';

class CartState {
  final bool isLoading;
  final String? error;
  final UserModel? auth;

  const CartState({
    this.isLoading = false,
    this.error,
    this.auth,
  });

  CartState copyWith({
    bool? isLoading,
    String? error,
    UserModel? auth,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      auth: auth ?? this.auth,
    );
  }
}
