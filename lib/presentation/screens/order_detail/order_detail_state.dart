class OrderDetailState {
	final bool isLoading;
	final String? error;
	  
	const OrderDetailState({
		this.isLoading = false,
		this.error,
	});
	  
	OrderDetailState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return OrderDetailState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
