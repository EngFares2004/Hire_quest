import 'package:hire_quest/configuration/network/end_point.dart';
import '../../../../configuration/network/dio_client.dart';

class VrCodeService {
  final DioClient _dioClient;

  VrCodeService(this._dioClient);

  Future<Map<String, dynamic>> generateVrCode() async {
    final response = await _dioClient.post(
      AppEndPoint.generateVrCode,
    );

    if (response.data == null) {
      throw Exception("Empty response from server");
    }

    return Map<String, dynamic>.from(response.data);
  }
}