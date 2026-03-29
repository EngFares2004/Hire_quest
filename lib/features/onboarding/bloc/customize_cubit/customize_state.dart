class CustomizeState {
  final String? selectedGender;
  final String? selectedLanguage;
  final bool isLoading;
  final bool isValid;
  final String? error;

  const CustomizeState({
    this.selectedGender,
    this.selectedLanguage,
    this.isLoading = false,
    this.isValid = false,
    this.error,
  });

  CustomizeState copyWith({
    String? selectedGender,
    String? selectedLanguage,
    bool? isLoading,
    bool? isValid,
    String? error,
  }) {
    return CustomizeState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      error: error,
    );
  }
}
