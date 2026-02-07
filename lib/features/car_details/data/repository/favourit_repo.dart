import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class FavouriteRepo {
  final Dio dio;

  FavouriteRepo({required this.dio});

  Future<bool> toggleFavourite({required int carId}) async {
    try {
      final token = CacheHelper.getString("token");
      final response = await dio.post(
        "${EndPoints.baseUrl}${EndPoints.favouriteToggle(carId)}",
        data: const {},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": "en",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }

      throw ServerExceptions(
        errorModel: ErrorModel(message: "Failed to toggle favourite"),
      );
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
