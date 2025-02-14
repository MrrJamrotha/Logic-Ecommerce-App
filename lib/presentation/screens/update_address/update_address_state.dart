import 'package:geolocator/geolocator.dart';

class UpdateAddressState {
  final bool isLoading;
  final String? error;
  final Position? position;

  const UpdateAddressState({
    this.isLoading = false,
    this.error,
    this.position,
  });

  UpdateAddressState copyWith({
    bool? isLoading,
    String? error,
    Position? position,
  }) {
    return UpdateAddressState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      position: position ?? this.position,
    );
  }
}
