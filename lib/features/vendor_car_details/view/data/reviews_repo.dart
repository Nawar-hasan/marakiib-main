import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/vendor_car_details/view/data/reviews_car_model.dart';

class CarReviewService {
  final Dio dio;

  CarReviewService(this.dio);

  Future<List<CarReviewModel>> getCarReviews(int carId) async {

    final token = CacheHelper.getString("token");

    final response = await dio.get(
      '${EndPoints.baseUrl}cars/$carId/reviews',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((e) => CarReviewModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load reviews: ${response.statusMessage}");
    }
  }
}
