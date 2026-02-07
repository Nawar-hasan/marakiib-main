import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<Response> getUser() async {
    final token = CacheHelper.getString("token");

    return await dio.get(
      EndPoints.baseUrl + EndPoints.getUser,
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }
}
