import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/search_home/data/models/search_model.dart';

class CarSearchRepo {
  final Dio dio;

  CarSearchRepo({required this.dio});

  // دالة داخلية لجلب الهيدر مع التوكن
  Future<Options> _getOptions() async {
    final token = CacheHelper.getString("token") ?? '';
    return Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Language": "en",
        "Authorization": "Bearer $token",
      },
    );
  }

  // ✅ البحث عن السيارات
  Future<List<CarModel>> searchCars({
    String? query,
    double? priceMin,
    double? priceMax,
    int? carTypeId,
    bool? nearest,
    double? latitude,
    double? longitude,
    String? usageNature,
    bool? longTermGuarantee, // ✅ جديد
  }) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.search}",
        queryParameters: {
          'query': query,
          'price_min': priceMin,
          'price_max': priceMax,
          'car_type_id': carTypeId,
          'nearest': nearest,
          'latitude': latitude,
          'longitude': longitude,
          'usage_nature': usageNature,
          'long_term_guarantee': longTermGuarantee == true ? 1 : null, // ✅ جديد
        }..removeWhere((key, value) => value == null),
        options: options,
      );

      if (response.data == null || response.data['data'] == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final cars = (response.data['data'] as List)
          .map((e) => CarModel.fromJson(e))
          .toList();

      return cars;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }

}
