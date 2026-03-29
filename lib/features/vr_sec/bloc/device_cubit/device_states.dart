
abstract class DeviceState {}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceEmpty extends DeviceState {

}

class DeviceConnected extends DeviceState {
  final Map<String, dynamic> device;

  DeviceConnected(this.device);
}

class DeviceError extends DeviceState {
  final String message;

  DeviceError(this.message);
}
