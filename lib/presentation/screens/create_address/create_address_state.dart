import 'package:geolocator/geolocator.dart';
import 'package:logic_app/data/models/address_model.dart';

class CreateAddressState {
  final bool isLoading;
  final String? error;
  final Position? position;
  final AddressModel? record;
  final String? address;
  final String? phoneNumber;

  const CreateAddressState({
    this.isLoading = false,
    this.error,
    this.position,
    this.record,
    this.address,
    this.phoneNumber,
  });

  CreateAddressState copyWith({
    bool? isLoading,
    String? error,
    Position? position,
    AddressModel? record,
    String? address,
    String? phoneNumber,
  }) {
    return CreateAddressState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      position: position ?? this.position,
      record: record ?? this.record,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
