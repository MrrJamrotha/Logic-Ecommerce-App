import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/service/geocoding_service.dart';
import 'package:foxShop/core/service/geolocator_service.dart';
import 'package:foxShop/core/service/user_session_service.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/repositories/address/address_repository_impl.dart';
import 'package:foxShop/presentation/screens/update_address/update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UpdateAddressCubit() : super(UpdateAddressState(isLoading: true));
  final geolocatorService = di.get<GeolocatorService>();
  final geocodingService = di.get<GeocodingService>();
  final userSessionService = di.get<UserSessionService>();
  final repos = di.get<AddressRepositoryImpl>();
  Future<void> loadInitialData(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getAddressById(parameters: {'id': id}).then((response) {
        response.fold((failure) {
          emit(state.copyWith(message: failure.message));
          showMessage(
            message: failure.message,
            status: MessageStatus.warning,
          );
        }, (success) {
          emit(
            state.copyWith(
              record: success,
              message: response.message,
              position: Position(
                longitude: AppFormat.toDouble(success.latitude),
                latitude: AppFormat.toDouble(success.longitude),
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
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> updateAddress({Map<String, dynamic>? parameters}) async {
    try {
      await repos.updateAddress(parameters: parameters).then((response) {
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
