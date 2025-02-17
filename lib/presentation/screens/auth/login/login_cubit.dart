import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/data/models/country_model.dart';
import 'package:logic_app/presentation/screens/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  List<CountryModel> _allCountries = [];
  Future<void> getCountries() async {
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
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(countries: _allCountries)); // Restore full list
    } else {
      var filteredCountries = _allCountries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(countries: filteredCountries));
    }
  }

  void selectDialcode(String code) {
    emit(state.copyWith(dialCode: code));
  }
}
