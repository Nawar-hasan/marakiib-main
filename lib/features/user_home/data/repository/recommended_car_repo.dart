import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/user_home/data/models/recommended_car_model.dart';

class RecommendedCarRepo {
  final Dio dio;

  RecommendedCarRepo({required this.dio});


  Future<Options> _getOptions() async {
    final token = CacheHelper.getString("token") ?? '';
    return Options(
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Accept-Language": "en",
        "Content-Type": "application/json",
      },
    );
  }


  Future<List<RecommendedCarModel>> getRecommendedCars() async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        EndPoints.baseUrl + EndPoints.recommendedCars,
        options: options,
      );

      print('API Response: ${response.data}'); // Add logging
      if (response.data == null || response.data.isEmpty) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final carsResponse = RecommendedCarsResponse.fromJson(response.data);
      print('Parsed Cars: ${carsResponse.cars}'); // Add logging
      if (carsResponse.cars.isEmpty) {
        return [];
      }
      return carsResponse.cars;
    } on DioException catch (e) {
      print('DioException: $e'); // Add logging
      throw handleDioException(e);
    } catch (e) {
      print('Unexpected Error: $e'); // Add logging
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }}
