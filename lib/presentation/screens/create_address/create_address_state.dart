import 'package:geolocator/geolocator.dart';
import 'package:logic_app/data/models/address_model.dart';

class CreateAddressState {
  final bool isLoading;
  final String? error;
  final Position? position;
  final AddressModel? record;
  final String? address;
  final String? phoneNumber;
  final String? message;

  const CreateAddressState({
    this.isLoading = false,
    this.error,
    this.position,
    this.record,
    this.address,
    this.phoneNumber,
    this.message,
  });

  CreateAddressState copyWith({
    bool? isLoading,
    String? error,
    Position? position,
    AddressModel? record,
    String? address,
    String? phoneNumber,
    String? message,
  }) {
    return CreateAddressState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      position: position ?? this.position,
      record: record ?? this.record,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
    );
  }
}
