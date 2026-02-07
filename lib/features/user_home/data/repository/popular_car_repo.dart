import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_home/data/models/popular_car_model.dart';

class PopularCarRepo {
  final Dio dio;

  PopularCarRepo({required this.dio});

  Future<List<PopularCarModel>> getPopularCarList() async {
    try {
      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.popularCars}",
        options: Options(
          headers: {"Accept": "application/json", "Accept-Language": "en"},
        ),
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final carsResponse = PopularCarsResponse.fromJson(response.data);
      return carsResponse.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
