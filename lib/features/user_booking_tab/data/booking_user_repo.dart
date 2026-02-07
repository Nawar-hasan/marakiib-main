import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_booking_tab/data/models/booking_car_model.dart';

class BookingUserRepository {
  final Dio dio;

  BookingUserRepository(this.dio);

  Future<List<BookingUserModel>> getBookings() async {
    try {
      final token = CacheHelper.getString("token") ?? '';
      final response = await dio.get(
        EndPoints.baseUrl + EndPoints.userBooking,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data'];
        return data.map((e) => BookingUserModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load user bookings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
