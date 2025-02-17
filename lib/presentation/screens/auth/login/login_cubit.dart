import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/data/models/country_model.dart';
import 'package:logic_app/presentation/screens/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> getCountries() async {
    final json = await rootBundle.loadString('assets/country_code.json');
    final countries = await Isolate.run<List<CountryModel>>(() {
      final countryData = jsonDecode(json) as List<Object?>;
      return countryData
          .cast<Map<String, Object?>>()
          .map(CountryModel.fromJson)
          .toList();
    });
    emit(state.copyWith(countries: countries));
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(countries: state.countries));
    } else {
      var datas = state.countries
          ?.where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(countries: datas));
    }
  }

  void selectDialcode(String code) {
    emit(state.copyWith(dialCode: code));
  }
}
