import '../../../../onboarding/data/models/user_preferences_options_model.dart';

class DefaultIVSettingState {
  final bool isLoading;
  final String? selectedEnvironment;
  final String? selectedGender;
  final String? selectedLanguage;
  final String? selectedPersona;
  final String? selectedLevel;
  final String? selectedPath;
  final String? selectedRole;
  final double selectedDuration;
  final UserPreferencesOptionsModel? data;
  final String? error;
  final bool isValid;
  final bool success;
  const DefaultIVSettingState({
    this.isLoading = false,
    this.success = false,
    this.selectedEnvironment,
    this.selectedGender,
    this.selectedLanguage,
    this.selectedPersona,
    this.selectedLevel,
    this.selectedPath,
    this.selectedRole,
    this.selectedDuration = 30,
    this.data,
    this.error,
    this.isValid = false,
  });

  DefaultIVSettingState copyWith({
    bool? isLoading,
    bool? success,
    String? selectedEnvironment,
    String? selectedGender,
    String? selectedLanguage,
     String? selectedPersona,
     String? selectedLevel,
     String? selectedPath,
     String? selectedRole,
    double? selectedDuration,
    UserPreferencesOptionsModel? data,
    String? error,
    bool? isValid,
  }) {
    return DefaultIVSettingState(
      isLoading: isLoading ?? this.isLoading,
      selectedEnvironment: selectedEnvironment ?? this.selectedEnvironment,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedPersona: selectedPersona ?? this.selectedPersona,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedPath: selectedPath ?? this.selectedPath,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      data: data ?? this.data,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
      success: success ?? this.success,
    );
  }
}
