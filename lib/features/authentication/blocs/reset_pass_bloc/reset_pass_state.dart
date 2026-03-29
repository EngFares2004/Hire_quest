
abstract class ResetPassState  {
  @override
  List<Object?> get props => [];
}

class PasswordInitial extends ResetPassState {}

class PasswordLoading extends ResetPassState {}

class PasswordSuccess extends ResetPassState {}

class PasswordError extends ResetPassState {
  final String message;

  PasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
