import 'package:dio/dio.dart';

import '../../../configuration/network/dio_client.dart';
import '../../../configuration/network/end_point.dart';
import '../data/model/interview_model.dart';

class InterviewService {

  final DioClient dioClient = DioClient();

  Future<List<InterviewModel>> getMyInterviews() async {

    try {

      final Response response =
      await dioClient.get(AppEndPoint.myInterviews);

      if (response.statusCode == 200) {

        final List data = response.data['data'];

        return data
            .map((e) => InterviewModel.fromJson(e))
            .toList();
      }

      throw Exception(response.data['message']);

    } catch (e) {
      throw Exception("Failed to load interviews: $e");
    }
  }
}