 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/repositories/user/user_repository_impl.dart';
import 'package:logic_app/presentation/screens/cubit/currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyState());
  final repos = di.get<UserRepositoryImpl>();
  Future<void> loadInit()async{
    try{
      emit(state.copyWith(isLoading :true));
      await repos.getUserProfile().then((response){
        response.fold((failure){}, (success){
          emit(state.copyWith(record:success));
        });
      });
      emit(state.copyWith(isLoading: false));
    }catch(error){
      addError(error);
    }
  }

  Future<void> changeCurrencyCode(String code) async{
    try{
      await repos.changeCurrencyCode(parameters: {
        'currency_code' : code
      }).then((response){
        response.fold((failure){
          showMessage(message: failure.message);
          emit(state.copyWith(error: failure.message));
        },(success){
          showMessage(message: response.message??"");
          emit(state.copyWith(record: success));
        });
      });

    }catch(error){
      addError(error);
    }
  }
 @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
 
}
