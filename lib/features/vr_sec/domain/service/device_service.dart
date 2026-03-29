import 'package:hire_quest/configuration/network/end_point.dart';

import '../../../../configuration/network/dio_client.dart';

class DeviceService {
  final DioClient dioClient;

  DeviceService(this.dioClient);

  Future<List<dynamic>> getDevices() async {
    final response = await dioClient.get(AppEndPoint.devices);

    if (response.data["success"] == true) {
      return response.data["data"] ?? [];
    } else {
      throw Exception(response.data["message"]);
    }
  }
}