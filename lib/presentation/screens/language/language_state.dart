import 'package:equatable/equatable.dart';
import 'package:foxShop/data/models/user_model.dart';

class LanguageState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final UserModel? record;

  const LanguageState({
    this.isLoading = false,
    this.errorMessage,
    this.record,
  });

  LanguageState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserModel? record,
  }) {
    return LanguageState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      record: record ?? this.record,
    );
  }

  @override
  List<Object?> get props => [];
}
