import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/vendor_financings/data/models/financed_car_model.dart';

class FinancedCarsRepository {
  final Dio dio;

  FinancedCarsRepository(this.dio);

  Future<List<FinancedCarModel>> fetchFinancedCars({
    String status = 'active',
  }) async {
    try {
      final token = await CacheHelper.getString("token");
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await dio.get(
        '${EndPoints.baseUrl}my-financed-cars',
        queryParameters: {'status': status},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => FinancedCarModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch financed cars');
      }
    } catch (e) {
      throw Exception('Error fetching financed cars: $e');
    }
  }
}
