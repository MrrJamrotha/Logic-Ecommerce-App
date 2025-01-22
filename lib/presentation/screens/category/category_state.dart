class CategoryState {
	final bool isLoading;
	final String? error;
	  
	const CategoryState({
		this.isLoading = false,
		this.error,
	});
	  
	CategoryState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return CategoryState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
