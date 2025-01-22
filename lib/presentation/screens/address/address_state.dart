class AddressState {
	final bool isLoading;
	final String? error;
	  
	const AddressState({
		this.isLoading = false,
		this.error,
	});
	  
	AddressState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return AddressState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
