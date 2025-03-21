import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool lightMode;
  final int currentIndex;

  const SettingState({
    this.isLoading = false,
    this.error,
    this.lightMode = true,
    this.currentIndex = 0,
  });

  SettingState copyWith({
    bool? isLoading,
    String? error,
    bool? lightMode,
    int? currentIndex,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      lightMode: lightMode ?? this.lightMode,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        lightMode,
        currentIndex,
      ];

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'lightMode': lightMode,
      'currentIndex': currentIndex,
    };
  }

  static SettingState fromJson(Map<String, dynamic> json) {
    return SettingState(
      isLoading: json['isLoading'],
      error: json['error'],
      lightMode: json['lightMode'],
      currentIndex: json['currentIndex'],
    );
  }
}
