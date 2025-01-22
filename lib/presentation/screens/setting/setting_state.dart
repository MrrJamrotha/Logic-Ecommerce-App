class SettingState {
  final bool isLoading;
  final String? error;
  final bool lightMode;

  const SettingState({
    this.isLoading = false,
    this.error,
    this.lightMode = true,
  });

  SettingState copyWith({
    bool? isLoading,
    String? error,
    bool? lightMode,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      lightMode: lightMode ?? this.lightMode,
    );
  }
}
