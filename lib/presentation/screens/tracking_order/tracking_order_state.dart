class TrackingOrderState {
	final bool isLoading;
	final String? error;
	  
	const TrackingOrderState({
		this.isLoading = false,
		this.error,
	});
	  
	TrackingOrderState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return TrackingOrderState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
