import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState> {
  CancelBookingCubit() : super(CancelBookingInitial());

  final Dio dio = Dio();

  Future<void> cancelBooking(int bookingId) async {
    emit(CancelBookingLoading());

    try {
      // هات التوكن من الكاش
      final token = CacheHelper.getString("token");

      if (token == null) {
        emit(CancelBookingFailure("User not authenticated"));
        return;
      }

      final response = await dio.post(
        "${EndPoints.baseUrl}bookings/$bookingId/cancel",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      emit(CancelBookingSuccess(
          response.data["message"] ?? "Booking canceled successfully"));
    } on DioException catch (e) {
      emit(CancelBookingFailure(
          e.response?.data["message"] ?? "Failed to cancel booking"));
    } catch (e) {
      emit(CancelBookingFailure(e.toString()));
    }
  }
}
