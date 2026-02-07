import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/network/end_point.dart';
import '../model/rental_office_register_model.dart';

class RentalOfficeRegisterRepository {
  final Dio _dio;

  RentalOfficeRegisterRepository(this._dio);

  Future<Response> registerRentalOffice(RentalOfficeRegisterModel user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? latitude = prefs.getDouble("user_lat");
      double? longitude = prefs.getDouble("user_lng");
      String? address = prefs.getString("user_address");

      FormData formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "otp_method": user.otpMethod,

        "password": user.password,
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
        "commercial_registration_number": user.commercialRegistrationNumber,
      });

      final response = await _dio.post(
        "${EndPoints.baseUrl}${EndPoints.registerEndPoint}",
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
          validateStatus: (_) => true,
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
