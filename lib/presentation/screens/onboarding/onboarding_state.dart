class OnboardingState {
	final bool isLoading;
	final String? error;
	  
	const OnboardingState({
		this.isLoading = false,
		this.error,
	});
	  
	OnboardingState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return OnboardingState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
