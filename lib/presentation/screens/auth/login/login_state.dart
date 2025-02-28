import 'package:foxShop/data/models/country_model.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final List<CountryModel>? countries;
  final String? dialCode;
  final String? message;
  final bool isLoadingOverlay;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.countries,
    this.dialCode = '+855',
    this.message,
    this.isLoadingOverlay = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    List<CountryModel>? countries,
    String? dialCode,
    String? message,
    bool? isLoadingOverlay,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      countries: countries ?? this.countries,
      dialCode: dialCode ?? this.dialCode,
      message: message ?? this.message,
      isLoadingOverlay: isLoadingOverlay ?? this.isLoadingOverlay,
    );
  }
}
