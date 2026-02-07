import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class AddReviewRepo {
  final Dio dio;

  AddReviewRepo({required this.dio});

  /// Adds a review for a specific car
  Future<void> addReview({
    required int carId,
    required int rating,
    required String comment,
  }) async {
    try {
      final token = CacheHelper.getString("token");
      final response = await dio.post(
        "${EndPoints.baseUrl}cars/$carId/reviews",
        data: {"rating": rating, "comment": comment},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": "en",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerExceptions(
          errorModel: ErrorModel(
            message:
                "Failed to add review. Status code: ${response.statusCode}",
          ),
        );
      }

      // Optionally return response data if API returns something
      return;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
