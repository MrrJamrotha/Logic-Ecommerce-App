class ContactUsState {
	final bool isLoading;
	final String? error;
	  
	const ContactUsState({
		this.isLoading = false,
		this.error,
	});
	  
	ContactUsState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return ContactUsState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
