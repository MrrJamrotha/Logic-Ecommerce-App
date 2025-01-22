import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/notification_detail/notification_detail_state.dart';

class NotificationDetailCubit extends Cubit<NotificationDetailState> {
	NotificationDetailCubit() : super(NotificationDetailState(isLoading: true));
	
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
