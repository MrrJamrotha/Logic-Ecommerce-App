class PrivacyTermsState {
	final bool isLoading;
	final String? error;
	  
	const PrivacyTermsState({
		this.isLoading = false,
		this.error,
	});
	  
	PrivacyTermsState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return PrivacyTermsState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
