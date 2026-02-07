import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class MyCarService {
  final Dio dio;

  MyCarService(this.dio) {
    dio.options.baseUrl = EndPoints.baseUrl;
  }

  Future<Response> getMyCars() async {
    final token = CacheHelper.getString("token");

    if (token == null) throw Exception("⚠️ Token not found");

    return await dio.get(
      EndPoints.myCar,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
}
