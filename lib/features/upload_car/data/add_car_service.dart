import 'dart:io';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class AddCarService {
  final Dio dio;

  AddCarService(this.dio);

  Future<Response> addCar(FormData formData) async {
    final token = CacheHelper.getString("token");
    if (token == null) {
      throw Exception("⚠️ توكن المصادقة غير موجود. الرجاء تسجيل الدخول.");
    }

    // هنا بنطبع التوكن
    print("🔑 Current Token: $token");

    try {
      final response = await dio.post(
        EndPoints.baseUrl + EndPoints.addCar,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
        e.response != null
            ? "❌ API Error: ${e.response?.statusCode} - ${e.response?.data ?? 'No data'}"
            : "❌ Network Error: ${e.message}",
      );
    }
  }
}
