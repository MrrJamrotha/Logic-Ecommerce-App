import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/geocoding_service.dart';
import 'package:logic_app/core/service/geolocator_service.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/data/repositories/address/address_repository_impl.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_state.dart';

class CreateAddressCubit extends Cubit<CreateAddressState> {
  CreateAddressCubit() : super(CreateAddressState(isLoading: true));
  final geolocatorService = di.get<GeolocatorService>();
  final geocodingService = di.get<GeocodingService>();
  final userSessionService = di.get<UserSessionService>();
  final repos = di.get<AddressRepositoryImpl>();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      var auth = await userSessionService.getUser();
      await geolocatorService.determinePosition().then((result) async {
        var address = await geocodingService.getAddressFromCoordinates(
          result.latitude,
          result.longitude,
        );
        emit(state.copyWith(
          position: result,
          address: address,
          phoneNumber: auth?.phoneNumber ?? "",
        ));
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> createAddress({Map<String, dynamic>? parameters}) async {
    try {
      await repos.createAddress(parameters: parameters).then((response) {
        response.fold((failure) {
          emit(state.copyWith(message: failure.message));
          showMessage(message: failure.message, status: MessageStatus.warning);
        }, (success) {
          emit(state.copyWith(
            record: success,
            message: response.message,
          ));
          showMessage(message: response.message ?? "");
        });
      });
    } catch (error) {
      addError(error);
    }
  }

  Future<void> updatePosition(CameraPosition position) async {
    emit(
      state.copyWith(
        position: Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        ),
      ),
    );
  }

  Future<void> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    var address =
        await geocodingService.getAddressFromCoordinates(latitude, longitude);
    emit(state.copyWith(address: address));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
