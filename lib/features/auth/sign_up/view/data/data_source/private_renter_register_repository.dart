import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/network/end_point.dart';
import '../model/private_renter_register_model.dart';

class PrivateRenterRegisterRepository {
  final Dio _dio;

  PrivateRenterRegisterRepository(this._dio);

  Future<Response> registerPrivateRenter(PrivateRenterRegisterModel user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? latitude = prefs.getDouble("user_lat");
      double? longitude = prefs.getDouble("user_lng");
      String? address = prefs.getString("user_address");

      FormData formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "otp_method": user.otpMethod,

        "password_confirmation": user.passwordConfirmation,
        "phone_number": user.phoneNumber,
        "address": address ?? user.address,
        "latitude": latitude?.toString() ?? "",
        "longitude": longitude?.toString() ?? "",
        "role": user.role,
        "car_license_image": await MultipartFile.fromFile(
          user.carLicenseImage,
          filename: "car_license.jpg",
        ),
        "car_license_expiry_date": user.carLicenseExpiryDate,
      });


      formData.fields.forEach((f) => print("${f.key}: ${f.value}"));
      formData.files.forEach((f) => print("${f.key}: ${f.value.filename}"));

      final response = await _dio.post(
        "${EndPoints.baseUrl}${EndPoints.registerEndPoint}",
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response data: ${response.data}");

      return response;
    } catch (e) {
      print("❌ Error in registerPrivateRenter: $e");
      rethrow;
    }
  }
}
