import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

class CarDetailsRepo {
  final Dio dio;

  CarDetailsRepo({required this.dio});

  Future<CarDetailsModel> getCarDetails({
    required int carId,
    String locale = 'en',
  }) async {
    try {
      final token = CacheHelper.getString("token");
      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.carDetails}/$carId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": locale,
            //  "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final carDetails = CarDetailsModel.fromJson(response.data);
      return carDetails;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
