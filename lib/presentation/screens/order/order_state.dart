class OrderState {
	final bool isLoading;
	final String? error;
	  
	const OrderState({
		this.isLoading = false,
		this.error,
	});
	  
	OrderState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return OrderState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
