class SearchState {
	final bool isLoading;
	final String? error;
	  
	const SearchState({
		this.isLoading = false,
		this.error,
	});
	  
	SearchState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return SearchState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
