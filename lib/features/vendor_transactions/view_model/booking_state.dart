import 'package:marakiib_app/features/vendor_transactions/data/models/transaction_car_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final List<BookingModel> bookings;
  BookingSuccess(this.bookings);
}

class BookingFailure extends BookingState {
  final String error;
  BookingFailure(this.error);
}
