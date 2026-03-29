import 'package:bloc/bloc.dart';

import '../../domain/service/device_service.dart';
import 'device_states.dart';


class DeviceCubit extends Cubit<DeviceState> {
  final DeviceService service;

  DeviceCubit(this.service) : super(DeviceInitial());

  Future<void> checkDevice() async {
    emit(DeviceLoading());

    try {
      final devices = await service.getDevices();



      final connectedDevice = devices.firstWhere(
            (d) => d["isConnected"] == true,
        orElse: () => null,
      );

      if (connectedDevice != null) {
        emit(DeviceConnected(connectedDevice));
      } else {

       emit(DeviceEmpty());
      }
    } catch (e) {
      emit(DeviceError(e.toString()));
    }
  }
}