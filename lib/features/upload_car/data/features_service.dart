import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/upload_car/data/model/features_model.dart';

class MyFeaturesService {
  final Dio dio;

  MyFeaturesService(this.dio);

  Future<MyFeaturesResponse> getMyFeatures() async {
    try {
      final response = await dio.get(
        '${EndPoints.baseUrl}${EndPoints.getFeatures}',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return MyFeaturesResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load features: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error: ${e.response?.data['message'] ?? 'Unknown error'}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
