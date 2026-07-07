abstract class PasswordState {}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordSuccess extends PasswordState {}

class PasswordError extends PasswordState {
  final String message;
  PasswordError(this.message);
}