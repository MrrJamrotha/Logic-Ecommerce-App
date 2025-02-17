import 'package:logic_app/data/models/country_model.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final List<CountryModel>? countries;
  final String? dialCode;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.countries,
    this.dialCode = '+855',
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    List<CountryModel>? countries,
    String? dialCode,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      countries: countries ?? this.countries,
      dialCode: dialCode ?? this.dialCode,
    );
  }
}
