import 'package:flutter_bloc/flutter_bloc.dart';
import 'define_path_state.dart';

class DefinePathCubit extends Cubit<DefinePathState> {
  DefinePathCubit() : super(const DefinePathState());
  void selectTrack(String value) {
    final role = value == "Other" ? '' : value;
    emit(
      state.copyWith(
        selectedTrack: value,
        role: role,
        isValid: _validate(role, state.selectedLevel),
      ),
    );
  }

  void writeRole(String value) {
    emit(
      state.copyWith(
        role: value,
        isValid: _validate(value, state.selectedLevel),
      ),
    );
  }

  void selectLevel(String value) {
    emit(
      state.copyWith(
        selectedLevel: value,
        isValid: _validate(state.role, value),
      ),
    );
  }

  bool _validate(String role, String? level) {
    return role.trim().isNotEmpty && level != null;
  }
}
