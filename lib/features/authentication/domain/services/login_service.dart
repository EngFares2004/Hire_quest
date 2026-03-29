import 'package:dio/dio.dart';
import '../../../../configuration/network/end_point.dart';

class LoginService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post(
      AppEndPoint.login,
      data: {
        "email": email,
        "password": password,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    return response.data;
  }
}
