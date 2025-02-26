
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/country_model.dart';
import 'package:logic_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:logic_app/presentation/screens/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  List<CountryModel> _allCountries = [];
  final repos = di.get<AuthRepositoryImpl>();

  Future<void> getCountries() async {
    try {
      final json = await rootBundle.loadString('assets/country_code.json');
      final countries = await Isolate.run<List<CountryModel>>(() {
        final countryData = jsonDecode(json) as List<Object?>;
        return countryData
            .cast<Map<String, Object?>>()
            .map(CountryModel.fromJson)
            .toList();
      });
      _allCountries = countries;
      emit(state.copyWith(countries: countries));
    } catch (e) {
      addError(e);
    }
  }

  Future<void> searchCountries(String query) async {
    try {
      if (query.isEmpty) {
        emit(state.copyWith(countries: _allCountries));
      } else {
        var filteredCountries = _allCountries
            .where((country) =>
                country.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(state.copyWith(countries: filteredCountries));
      }
    } catch (e) {
      addError(e);
    }
  }

  void selectDialcode(String code) {
    emit(state.copyWith(dialCode: code));
  }

  Future<bool> generateOtpCode({Map<String, dynamic>? parameters}) async {
    try {
      emit(state.copyWith(isLoadingOverlay: true));

      final result =
          await repos.generateOtpCode(parameters: parameters).then((response) {
        return response.fold((failure) {
          emit(state.copyWith(
            isLoadingOverlay: false,
            message: failure.message,
          ));
          return false;
        }, (success) {
          emit(state.copyWith(
            message: response.message,
            isLoadingOverlay: false,
          ));
          return true;
        });
      });

      return result;
    } catch (e) {
      addError(e);
      emit(state.copyWith(isLoadingOverlay: false));
      return false;
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
