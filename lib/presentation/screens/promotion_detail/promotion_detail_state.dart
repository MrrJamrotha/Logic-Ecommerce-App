class PromotionDetailState {
	final bool isLoading;
	final String? error;
	  
	const PromotionDetailState({
		this.isLoading = false,
		this.error,
	});
	  
	PromotionDetailState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return PromotionDetailState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
