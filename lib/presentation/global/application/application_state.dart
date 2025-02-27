import 'package:equatable/equatable.dart';

class ApplicationState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool onBoarding;
  final bool isDarkModeTheme;
  final String? localeCode;

  const ApplicationState({
    this.isLoading = false,
    this.error,
    this.onBoarding = false,
    this.isDarkModeTheme = false,
    this.localeCode = "en",
  });

  ApplicationState copyWith({
    bool? isLoading,
    String? error,
    bool? onBoarding,
    bool? isDarkModeTheme,
    String? localeCode,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      onBoarding: onBoarding ?? this.onBoarding,
      isDarkModeTheme: isDarkModeTheme ?? this.isDarkModeTheme,
      localeCode: localeCode ?? this.localeCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error ?? '',
      'onBoarding': onBoarding,
      'isDarkModeTheme': isDarkModeTheme,
      'localeCode': localeCode,
    };
  }

  static ApplicationState fromJson(Map<String, dynamic> json) {
    return ApplicationState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'] ?? "",
      onBoarding: json['onBoarding'] ?? false,
      isDarkModeTheme: json['isDarkModeTheme'] ?? false,
      localeCode: json['localeCode'] ?? "en",
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        onBoarding,
        isDarkModeTheme,
        localeCode,
      ];
}
