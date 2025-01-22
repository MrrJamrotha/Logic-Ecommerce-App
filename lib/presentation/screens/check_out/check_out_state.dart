class CheckOutState {
	final bool isLoading;
	final String? error;
	  
	const CheckOutState({
		this.isLoading = false,
		this.error,
	});
	  
	CheckOutState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return CheckOutState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
