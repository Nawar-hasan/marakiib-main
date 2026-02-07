import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class ForgetPasswordService {
  final Dio dio;

  ForgetPasswordService(this.dio);

  Future<Response> forgetPassword({
    required String email,
    required String otpMethod,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.forgetPassword,
        data: {
          "email": email,
          "otp_method": otpMethod,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
