import 'package:flutter_bloc/flutter_bloc.dart';

import 'customize_state.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit() : super(const CustomizeState());

  void selectGender(String gender) {
    emit(
      state.copyWith(
        selectedGender: gender,
        isValid: _validate(gender, state.selectedLanguage),
      ),
    );
  }

  void selectLanguage(String language) {
    emit(
      state.copyWith(
        selectedLanguage: language,
        isValid: _validate(state.selectedGender, language),
      ),
    );
  }

  bool _validate(String? gender, String? language) {
    return gender != null &&
        gender.isNotEmpty &&
        language != null &&
        language.isNotEmpty;
  }
}
