class DefinePathState {
  final List<String> tracks;
  final List<String> levels;
  final String? selectedTrack;
  final String? selectedLevel;
  final String role;
  final bool isValid;
  final bool isLoading;
  final String? error;

  const DefinePathState({
    this.tracks = const [],
    this.levels = const [],
    this.selectedTrack,
    this.selectedLevel,
    this.role = '',
    this.isValid = false,
    this.isLoading = false,
    this.error,
  });

  DefinePathState copyWith({
    List<String>? tracks,
    List<String>? levels,
    String? selectedTrack,
    String? selectedLevel,
    String? role,
    bool? isValid,
    bool? isLoading,
    String? error,
  }) {
    return DefinePathState(
      tracks: tracks ?? this.tracks,
      levels: levels ?? this.levels,
      selectedTrack: selectedTrack ?? this.selectedTrack,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      role: role ?? this.role,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
