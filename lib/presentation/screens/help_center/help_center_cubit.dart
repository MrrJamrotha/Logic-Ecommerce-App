import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/help_center/help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
	HelpCenterCubit() : super(HelpCenterState(isLoading: true));
	
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
