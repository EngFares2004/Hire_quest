import 'package:flutter_bloc/flutter_bloc.dart';
import 'atmosphere_state.dart';

class AtmosphereCubit extends Cubit<AtmosphereState> {
  AtmosphereCubit() : super(const AtmosphereState());

  void selectEnvironment(String value) {
    emit(
      state.copyWith(
        selectedEnvironment: value,
        isValid: _validate(value, state.selectedPersona),
      ),
    );
  }

  void selectPersona(String value) {
    emit(
      state.copyWith(
        selectedPersona: value,
        isValid: _validate(state.selectedEnvironment, value),
      ),
    );
  }

  bool _validate(String? environment, String? persona) {
    return environment != null && persona != null;
  }
}


