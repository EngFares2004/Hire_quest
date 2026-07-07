import 'package:dio/dio.dart';

import '../../../configuration/network/dio_client.dart';
import '../../../configuration/network/end_point.dart';

class InterviewDetailsService {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>> getInterviewDetails(String id) async {
    try {
      final Response response =
      await dioClient.get('${AppEndPoint.interviewById}$id');

      print("🔥 DETAILS RESPONSE: ${response.data}");

      if (response.statusCode == 200) {
        return response.data['data'];
      }

      throw Exception(response.data['message']);
    } catch (e) {
      throw Exception("Failed to load interview details: $e");
    }
  }
}