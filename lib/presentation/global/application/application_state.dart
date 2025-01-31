class ApplicationState {
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
}
