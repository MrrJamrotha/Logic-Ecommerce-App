class OtpState {
	final bool isLoading;
	final String? error;
	  
	const OtpState({
		this.isLoading = false,
		this.error,
	});
	  
	OtpState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return OtpState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
