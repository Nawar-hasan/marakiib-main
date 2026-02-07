import 'package:dio/dio.dart';

import '../../../../../core/network/end_point.dart';
import 'login_model.dart';

class LoginRepository {
  final Dio _dio;

  LoginRepository(this._dio);

  Future<Response> loginUser(LoginModel login) async {
    try {
      final response = await _dio.post(
        "${EndPoints.baseUrl}${EndPoints.loginEndPoint}",
        data: login.toMap(),
        options: Options(
          headers: {"Accept": "application/json"},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
