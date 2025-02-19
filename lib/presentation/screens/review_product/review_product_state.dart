class ReviewProductState {
	final bool isLoading;
	final String? error;
	  
	const ReviewProductState({
		this.isLoading = false,
		this.error,
	});
	  
	ReviewProductState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return ReviewProductState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
