import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/network/end_point.dart';
import '../model/register_model.dart';

class UserRegisterRepository {
  final Dio _dio;

  UserRegisterRepository(this._dio);

  Future<Response> registerUser(UserRegisterModel user) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? latitude = prefs.getDouble("user_lat");
      double? longitude = prefs.getDouble("user_lng");
      String? address = prefs.getString("user_address");

      FormData formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "password_confirmation": user.passwordConfirmation,
        "phone_number": user.phoneNumber,
        "otp_method": user.otpMethod,

        "address": address ?? user.address,
        "latitude": latitude?.toString() ?? "",
        "longitude": longitude?.toString() ?? "",
        "role": user.role,
        "driving_license_image": await MultipartFile.fromFile(
          user.drivingLicenseImage,
          filename: "driving_license.jpg",
        ),
      });

      final response = await _dio.post(
        "${EndPoints.baseUrl}${EndPoints.registerEndPoint}",
        data: formData,
        options: Options(headers: {"Accept": "application/json"}),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
