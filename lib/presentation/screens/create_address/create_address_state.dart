import 'package:geolocator/geolocator.dart';

class CreateAddressState {
  final bool isLoading;
  final String? error;
  final Position? position;

  const CreateAddressState({
    this.isLoading = false,
    this.error,
    this.position,
  });

  CreateAddressState copyWith({
    bool? isLoading,
    String? error,
    Position? position,
  }) {
    return CreateAddressState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      position: position ?? this.position,
    );
  }
}
