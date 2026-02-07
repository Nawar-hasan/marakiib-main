import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_action_state.dart';

class BookingActionCubit extends Cubit<BookingActionState> {
  final Dio dio;

  BookingActionCubit(this.dio) : super(BookingActionInitial());

  Future<void> confirmBooking(int bookingId) async {
    emit(BookingActionLoading());
    try {
      final token = CacheHelper.getString("token") ?? "";
      final response = await dio.post(
        '${EndPoints.baseUrl}bookings/$bookingId/confirm',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        emit(BookingActionSuccess(bookingId, true));
      } else {
        emit(BookingActionFailure('Failed to confirm'));
      }
    } catch (e) {
      emit(BookingActionFailure(e.toString()));
    }
  }

  Future<void> rejectBooking(int bookingId) async {
    emit(BookingActionLoading());
    try {
      final token = CacheHelper.getString("token") ?? "";
      final response = await dio.post(
        '${EndPoints.baseUrl}bookings/$bookingId/reject',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        emit(BookingActionSuccess(bookingId, false));
      } else {
        emit(BookingActionFailure('Failed to reject'));
      }
    } catch (e) {
      emit(BookingActionFailure(e.toString()));
    }
  }
}
