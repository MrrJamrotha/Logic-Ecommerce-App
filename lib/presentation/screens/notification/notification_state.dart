class NotificationState {
	final bool isLoading;
	final String? error;
	  
	const NotificationState({
		this.isLoading = false,
		this.error,
	});
	  
	NotificationState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return NotificationState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
