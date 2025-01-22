class CartState {
	final bool isLoading;
	final String? error;
	  
	const CartState({
		this.isLoading = false,
		this.error,
	});
	  
	CartState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return CartState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
