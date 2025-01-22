class FetchingItemsState {
	final bool isLoading;
	final String? error;
	  
	const FetchingItemsState({
		this.isLoading = false,
		this.error,
	});
	  
	FetchingItemsState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return FetchingItemsState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
