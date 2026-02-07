import 'package:marakiib_app/features/user_booking_tab/data/models/booking_car_model.dart';


abstract class BookingUserState {}

class BookingUserInitial extends BookingUserState {}

class BookingUserLoading extends BookingUserState {}

class BookingUserSuccess extends BookingUserState {
  final List<BookingUserModel> bookings;
  BookingUserSuccess(this.bookings);
}

class BookingUserFailure extends BookingUserState {
  final String error;
  BookingUserFailure(this.error);
}
