import 'package:logic_app/data/models/brand_model.dart';

class BrandState {
  final bool isLoading;
  final String? error;
  final List<BrandModel>? records;

  const BrandState({
    this.isLoading = false,
    this.error,
    this.records,
  });

  BrandState copyWith({
    bool? isLoading,
    String? error,
    List<BrandModel>? records,
  }) {
    return BrandState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
    );
  }
}
