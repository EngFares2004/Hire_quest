import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/network/end_point.dart';


class HomeDataSource {
  final DioClient client;

  HomeDataSource(this.client);

  Future<Map<String, dynamic>> fetchHome() async {
    final response = await client.get(
      AppEndPoint.myProfile,
      queryParameters: {
        "includePreferences": true,
        "includeStatistics": true,
      },
    );

    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw Exception(response.data['message']);
    }
  }
}