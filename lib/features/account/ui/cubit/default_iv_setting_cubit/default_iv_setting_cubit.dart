import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../../domain/models/interview_setup.dart';
import '../../../domain/models/preferences_model.dart';
import 'default_iv_setting_state.dart';

class DefaultIVSettingCubit extends Cubit<DefaultIVSettingState> {
  final OnboardingRepository repo;

  DefaultIVSettingCubit(this.repo)
      : super(const DefaultIVSettingState()) {

    loadOptions();

    loadUserPreferences();
  }

  // ================= INIT =================

  Future<void> initialize() async {
    await loadOptions();

    await loadUserPreferences();

    await _loadSavedSetup();
  }

  // ================= LOAD OPTIONS =================

  Future<void> loadOptions() async {
    emit(state.copyWith(isLoading: true));

    try {
      final data = await repo.getOptions();

      emit(state.copyWith(
        data: data,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  // ================= LOAD USER PREFERENCES =================

  Future<void> loadUserPreferences() async {
    try {
      final data = await repo.getUserPreferences();

      emit(state.copyWith(
        selectedEnvironment: data.environmentType,
        selectedGender: data.interviewerGender,
        selectedLanguage: data.interviewLanguage,
        selectedPersona: data.interviewerPersonality,
        selectedLevel: data.userLevel,
        selectedRole: data.jobTitle,
        isValid: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  // ================= LOCAL CACHE =================

  Future<void> _loadSavedSetup() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString('interview_setup');

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);

      final setup = InterviewSetupModel.fromJson(jsonMap);

      emit(state.copyWith(
        selectedEnvironment: setup.environment,
        selectedGender: setup.gender,
        selectedLanguage: setup.language,
        selectedPersona: setup.persona,
        selectedDuration: setup.duration,
        selectedLevel: setup.level,
        selectedPath: setup.path,
        selectedRole: setup.role,
        isValid: true,
      ));
    }
  }

  Future<void> saveSetup() async {
    final setup = setupData;

    if (setup == null) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'interview_setup',
      jsonEncode(setup.toJson()),
    );
  }

  // ================= UPDATE API =================

  Future<void> updatePreferences() async {
    try {
      emit(state.copyWith(isLoading: true));

      final model = UserPreferencesModelEdit(
        jobTitle: state.selectedRole ?? "",
        userLevel: state.selectedLevel ?? "",
        environmentType: state.selectedEnvironment ?? "",
        interviewerPersonality: state.selectedPersona ?? "",
        interviewerGender: state.selectedGender ?? "",
        interviewLanguage: state.selectedLanguage ?? "",
      );

      await repo.updateUserPreferences(model);

      /// save local cache
      await saveSetup();

      emit(state.copyWith(
        isLoading: false,
        success: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  // ================= SETUP DATA =================

  InterviewSetupModel? get setupData {
    if (state.selectedEnvironment == null ||
        state.selectedGender == null ||
        state.selectedLanguage == null ||
        state.selectedPersona == null ||
        state.selectedLevel == null ||
        state.selectedPath == null ||
        state.selectedRole == null) {
      return null;
    }

    return InterviewSetupModel(
      environment: state.selectedEnvironment!,
      gender: state.selectedGender!,
      language: state.selectedLanguage!,
      persona: state.selectedPersona!,
      duration: state.selectedDuration,
      level: state.selectedLevel!,
      path: state.selectedPath!,
      role: state.selectedRole!,
    );
  }

  // ================= SELECT ENVIRONMENT =================

  void selectEnvironment(String value) {
    emit(state.copyWith(
      selectedEnvironment: value,
      isValid: _validate(
        value,
        state.selectedGender,
        state.selectedLanguage,
        state.selectedPersona,
        state.selectedDuration,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT GENDER =================

  void selectGender(String value) {
    emit(state.copyWith(
      selectedGender: value,
      isValid: _validate(
        state.selectedEnvironment,
        value,
        state.selectedLanguage,
        state.selectedPersona,
        state.selectedDuration,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT LANGUAGE =================

  void selectLanguage(String value) {
    emit(state.copyWith(
      selectedLanguage: value,
      isValid: _validate(
        state.selectedEnvironment,
        state.selectedGender,
        value,
        state.selectedPersona,
        state.selectedDuration,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT PERSONA =================

  void selectPersona(String value) {
    emit(state.copyWith(
      selectedPersona: value,
      isValid: _validate(
        state.selectedEnvironment,
        state.selectedGender,
        state.selectedLanguage,
        value,
        state.selectedDuration,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT LEVEL =================

  void selectLevel(String value) {
    emit(state.copyWith(
      selectedLevel: value,
      isValid: _validate2(
        value,
        state.selectedPath,
        state.selectedRole,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT PATH =================

  void selectPath(String value) {
    emit(state.copyWith(
      selectedPath: value,
      isValid: _validate2(
        state.selectedLevel,
        value,
        state.selectedRole,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT ROLE =================

  void selectRole(String value) {
    emit(state.copyWith(
      selectedRole: value,
      isValid: _validate2(
        state.selectedLevel,
        state.selectedPath,
        value,
      ),
    ));

    saveSetup();
  }

  // ================= SELECT DURATION =================

  void selectDuration(double value) {
    emit(state.copyWith(
      selectedDuration: value,
      isValid: _validate(
        state.selectedEnvironment,
        state.selectedGender,
        state.selectedLanguage,
        state.selectedPersona,
        value,
      ),
    ));

    saveSetup();
  }

  // ================= VALIDATION =================

  bool _validate(
      String? environment,
      String? gender,
      String? language,
      String? persona,
      double duration,
      ) {
    return environment != null &&
        environment.isNotEmpty &&
        gender != null &&
        gender.isNotEmpty &&
        language != null &&
        language.isNotEmpty &&
        persona != null &&
        persona.isNotEmpty &&
        duration >= 10;
  }

  bool _validate2(
      String? level,
      String? path,
      String? role,
      ) {
    return level != null &&
        level.isNotEmpty &&
        path != null &&
        path.isNotEmpty &&
        role != null &&
        role.isNotEmpty;
  }
}