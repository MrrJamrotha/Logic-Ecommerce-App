class NotificationDetailState {
	final bool isLoading;
	final String? error;
	  
	const NotificationDetailState({
		this.isLoading = false,
		this.error,
	});
	  
	NotificationDetailState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return NotificationDetailState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
