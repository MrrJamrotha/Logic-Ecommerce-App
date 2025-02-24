class EditProfileState {
	final bool isLoading;
	final String? error;
	  
	const EditProfileState({
		this.isLoading = false,
		this.error,
	});
	  
	EditProfileState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return EditProfileState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
