import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/device_cubit/device_cubit.dart';
import '../../bloc/device_cubit/device_states.dart';
import '../screens/add_vr.dart';
import '../screens/empty_vr.dart';

class DeviceRouterScreen extends StatelessWidget {
  const DeviceRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {

        if (state is DeviceLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DeviceConnected) {
          return AddVr(device: state.device);
        }

        if (state is DeviceEmpty) {
        return const EmptyVr();
        }

        if (state is DeviceError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }

        return const SizedBox();
      },
    );
  }
}