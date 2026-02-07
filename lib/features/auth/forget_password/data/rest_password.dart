import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class ResetPasswordService {
  final Dio dio;

  ResetPasswordService(this.dio);

  Future<Response> resetPassword({
    required String email,
    required String otpCode,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.restPassword,
        data: {
          "email": email,
          "otp_code": otpCode,
          "password": password,
          "password_confirmation": confirmPassword,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
