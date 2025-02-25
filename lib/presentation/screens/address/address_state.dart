import 'package:logic_app/data/models/address_model.dart';

class AddressState {
  final bool isLoading;
  final String? error;
  final List<AddressModel>? records;
  final int lastPage;
  final int currentPage;

  const AddressState({
    this.isLoading = false,
    this.error,
    this.records,
    this.lastPage = 1,
    this.currentPage = 1,
  });

  AddressState copyWith({
    bool? isLoading,
    String? error,
    List<AddressModel>? records,
    int? lastPage,
    int? currentPage,
  }) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
      lastPage: lastPage ?? this.lastPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
