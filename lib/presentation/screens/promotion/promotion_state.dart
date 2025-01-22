class PromotionState {
	final bool isLoading;
	final String? error;
	  
	const PromotionState({
		this.isLoading = false,
		this.error,
	});
	  
	PromotionState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return PromotionState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
