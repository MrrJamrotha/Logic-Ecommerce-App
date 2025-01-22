class HelpCenterState {
	final bool isLoading;
	final String? error;
	  
	const HelpCenterState({
		this.isLoading = false,
		this.error,
	});
	  
	HelpCenterState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return HelpCenterState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
