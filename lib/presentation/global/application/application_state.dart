import 'package:equatable/equatable.dart';

class ApplicationState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool onBoarding;
  final bool isDarkModeTheme;

  const ApplicationState({
    this.isLoading = false,
    this.error,
    this.onBoarding = false,
    this.isDarkModeTheme = false,
  });

  ApplicationState copyWith({
    bool? isLoading,
    String? error,
    bool? onBoarding,
    bool? isDarkModeTheme,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      onBoarding: onBoarding ?? this.onBoarding,
      isDarkModeTheme: isDarkModeTheme ?? this.isDarkModeTheme,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error ?? '',
      'onBoarding': onBoarding,
      'isDarkModeTheme': isDarkModeTheme,
    };
  }

  static ApplicationState fromJson(Map<String, dynamic> json) {
    return ApplicationState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'] ?? "",
      onBoarding: json['onBoarding'] ?? false,
      isDarkModeTheme: json['isDarkModeTheme'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        onBoarding,
        isDarkModeTheme,
      ];
}
