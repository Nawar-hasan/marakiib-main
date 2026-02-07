import 'package:dio/dio.dart';
import '../../../../../../core/network/end_point.dart';
import '../model/verify_otp_model.dart';

class VerifyOtpRepository {
  final Dio _dio;

  VerifyOtpRepository(this._dio);

  Future<Response> verifyOtp(VerifyOtpModel data) async {
    try {
      final response = await _dio.post(
        EndPoints.baseUrl + EndPoints.verifyOtpEndPoint,
        data: data.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
