import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/geolocator_service.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UpdateAddressCubit() : super(UpdateAddressState(isLoading: true));
  final geolocatorService = di.get<GeolocatorService>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await geolocatorService.determinePosition().then((result) {
        emit(state.copyWith(position: result));
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }
}
