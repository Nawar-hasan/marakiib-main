import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/booking_screen/view_model/add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  final Dio dio;
  AddBookCubit(this.dio) : super(AddBookInitial());

  Future<void> addBooking({
    required int carId,
    required String startDate,
    required String endDate,
    required String contactNumber,
    List<String>? extraOptions,
    int pickupDelivery = 0,
  }) async {
    emit(AddBookLoading());
    try {
      final token = await CacheHelper.getString("token");
      print("AddBookCubit: Retrieved token: $token");

      if (token == null) {
        emit(AddBookError("No token found. Please log in again."));
        return;
      }

      final response = await dio.post(
        "${EndPoints.baseUrl}${EndPoints.addBooking}",
        data: {
          "car_id": carId,
          "start_date": startDate,
          "end_date": endDate,
          "contact_number": contactNumber,
          "extra_options": extraOptions ?? [],
          "pickup_delivery": pickupDelivery,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      emit(AddBookSuccess(response.data));
    } catch (e) {
      String errorMessage = 'Failed to add booking';
      if (e is DioError && e.response != null) {
        errorMessage = e.response?.data['message'] ?? e.toString();
      }
      emit(AddBookError(errorMessage));
    }
  }
}
