import 'dart:io';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import '../../../core/network/end_point.dart';

class ProfileRepository {
  final Dio dio;

  ProfileRepository(this.dio);

  Future<Map<String, dynamic>> getProfile() async {
    final token = CacheHelper.getString("token");
    if (token == null) throw Exception("Token not found");

    final response = await dio.get(
      '${EndPoints.baseUrl}${EndPoints.getUser}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    File? image,
  }) async {
    final token = CacheHelper.getString("token");
    if (token == null) throw Exception("Token not found");

    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      if (image != null)
        "image": await MultipartFile.fromFile(
          image.path,
          filename: "avatar.jpg",
        ),
    });

    final response = await dio.post(
      '${EndPoints.baseUrl}${EndPoints.updateUser}',
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response.data;
  }
}
