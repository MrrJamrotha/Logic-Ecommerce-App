import 'package:equatable/equatable.dart';
import 'package:foxShop/data/models/user_model.dart';

class CurrencyState extends Equatable {
  final bool isLoading;
  final UserModel? record;
  final String? error;

  const CurrencyState({
    this.isLoading = false,
    this.error,
    this.record,
  });

  CurrencyState copyWith({
    String? error,
    UserModel? record,
    bool? isLoading,
  }) {
    return CurrencyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      record: record ?? this.record,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        record,
      ];
}
