import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/auth/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
	RegisterCubit() : super(RegisterState(isLoading: true));
	
	Future<void> loadInitialData() async {
		final stableState = state;
		try {
		  emit(state.copyWith(isLoading: true));
	
		  // TODO your code here
	
		  emit(state.copyWith(isLoading: false));
		} catch (error) {
		  emit(state.copyWith(error: error.toString()));
		  emit(stableState.copyWith(isLoading: false));
		}
	}
}
