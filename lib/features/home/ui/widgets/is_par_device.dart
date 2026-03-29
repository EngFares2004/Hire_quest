import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../vr_sec/bloc/device_cubit/device_cubit.dart';
import '../../../vr_sec/bloc/device_cubit/device_states.dart';
import '../../../vr_sec/ui/screens/add_vr.dart';
import '../../../vr_sec/ui/widgets/header_vr_code.dart';
import 'not_linked.dart';



class IsParDevice extends StatelessWidget {
  const IsParDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceCubit, DeviceState>(
      listener: (context, state) {
        if (state is DeviceEmpty) {
          NotLinkedBottomSheet.show(context);
        }
      },
      child: BlocBuilder<DeviceCubit, DeviceState>(
        builder: (context, state) {

          if (state is DeviceLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is DeviceConnected) {
            return AddVr(device: state.device);
          }

          if (state is DeviceError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }

          return const Scaffold(
            body:    Padding(
              padding: EdgeInsets.all(16),
              child: HeaderVrCode(title: ''),
            ),
          );
        },
      ),
    );
  }
}