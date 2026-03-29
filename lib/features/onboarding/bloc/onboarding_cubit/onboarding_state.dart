class OnboardingState {
  final int page;
  final bool definePathValid;
  final bool atmosphereValid;
  final bool customizeValid;
  final bool isSubmitting;
  final bool submitted;
  final bool isLoading;
  final String? error;

  const OnboardingState({
    this.page = 0,
    this.definePathValid = false,
    this.atmosphereValid = false,
    this.customizeValid = false,
    this.isSubmitting = false,
    this.submitted = false,
    this.isLoading = false,
    this.error,
  });

  bool get canContinue {
    if (page == 0) return definePathValid;
    if (page == 1) return atmosphereValid;
    return customizeValid;
  }

  OnboardingState copyWith({
    int? page,
    bool? definePathValid,
    bool? atmosphereValid,
    bool? customizeValid,
    bool? isSubmitting,
    bool? submitted,
    bool? isLoading,
    String? error,

  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      definePathValid: definePathValid ?? this.definePathValid,
      atmosphereValid: atmosphereValid ?? this.atmosphereValid,
      customizeValid: customizeValid ?? this.customizeValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitted: submitted ?? this.submitted,
      error: error ?? this.error,
    );
  }
}
