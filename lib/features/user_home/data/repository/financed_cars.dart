// lib/features/user_home/data/repository/cars_service.dart
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_home/data/models/financed_car_model.dart';

class CarsService {
  final Dio _dio;

  CarsService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  Future<List<FinancedCarModel>> fetchFinancedCars() async {
    try {
      final response = await Dio().get('${EndPoints.baseUrl}${EndPoints.financedCars}');
      print(response.data);
      final List data = response.data['data'];
      return data.map((e) => FinancedCarModel.fromJson(e)).toList();
    } catch (e) {
      print('Error: $e');
      throw Exception(e.toString());
    }
  }
}
