class ChatRoomState {
	final bool isLoading;
	final String? error;
	  
	const ChatRoomState({
		this.isLoading = false,
		this.error,
	});
	  
	ChatRoomState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return ChatRoomState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
