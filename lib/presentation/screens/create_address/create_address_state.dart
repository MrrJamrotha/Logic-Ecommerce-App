class CreateAddressState {
	final bool isLoading;
	final String? error;
	  
	const CreateAddressState({
		this.isLoading = false,
		this.error,
	});
	  
	CreateAddressState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return CreateAddressState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
