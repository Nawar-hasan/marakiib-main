import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import '../data/financing_model.dart';

class FinancingRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  Future<Response> addFinancing(FinancingModel model) async {
    final token = CacheHelper.getString("token");

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    final response = await _dio.post(
      EndPoints.financings,
      data: model.toJson(),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    return response;
  }
}
