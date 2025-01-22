class ChatState {
	final bool isLoading;
	final String? error;
	  
	const ChatState({
		this.isLoading = false,
		this.error,
	});
	  
	ChatState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return ChatState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
