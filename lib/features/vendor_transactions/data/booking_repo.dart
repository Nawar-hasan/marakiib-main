import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/vendor_transactions/data/models/transaction_car_model.dart';

class BookingRepository {
  final Dio dio;

  BookingRepository(this.dio);

  Future<List<BookingModel>> getBookings() async {
    try {
      final token = CacheHelper.getString("token") ?? '';
      final response = await dio.get(
        EndPoints.baseUrl + EndPoints.myBooking,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );


      if (response.statusCode == 200) {
        List data = response.data['data'];
        return data.map((e) => BookingModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
