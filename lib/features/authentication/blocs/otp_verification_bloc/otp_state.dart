
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSent extends OtpState {}

class OtpVerified extends OtpState {}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpSuccess extends OtpState {}

class OtpTimerChanged extends OtpState {
  final int timer;
  OtpTimerChanged(this.timer);
}
