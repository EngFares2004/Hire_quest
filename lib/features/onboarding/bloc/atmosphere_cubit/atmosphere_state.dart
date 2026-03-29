class AtmosphereState {
  final List<String> environments;
  final List<String> personas;
  final String? selectedEnvironment;
  final String? selectedPersona;
  final bool isValid;
  final bool isLoading;
  final String? error;

  const AtmosphereState({
    this.environments = const [],
    this.personas = const [],
    this.selectedEnvironment,
    this.selectedPersona,
    this.isValid = false,
    this.isLoading = false,
    this.error,
  });

  AtmosphereState copyWith({
    List<String>? environments,
    List<String>? personas,
    String? selectedEnvironment,
    String? selectedPersona,
    bool? isValid,
    bool? isLoading,
    String? error,
  }) {
    return AtmosphereState(
      environments: environments ?? this.environments,
      personas: personas ?? this.personas,
      selectedEnvironment: selectedEnvironment ?? this.selectedEnvironment,
      selectedPersona: selectedPersona ?? this.selectedPersona,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
