class FeedbackState {
	final bool isLoading;
	final String? error;
	  
	const FeedbackState({
		this.isLoading = false,
		this.error,
	});
	  
	FeedbackState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return FeedbackState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
