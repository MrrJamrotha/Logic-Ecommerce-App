class MerchantProfileState {
	final bool isLoading;
	final String? error;
	  
	const MerchantProfileState({
		this.isLoading = false,
		this.error,
	});
	  
	MerchantProfileState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return MerchantProfileState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
