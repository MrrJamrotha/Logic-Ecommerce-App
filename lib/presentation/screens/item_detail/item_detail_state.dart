class ItemDetailState {
	final bool isLoading;
	final String? error;
	  
	const ItemDetailState({
		this.isLoading = false,
		this.error,
	});
	  
	ItemDetailState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return ItemDetailState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
