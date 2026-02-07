import 'package:meta/meta.dart';

abstract class CancelBookingState {}

class CancelBookingInitial extends CancelBookingState {}

class CancelBookingLoading extends CancelBookingState {}

class CancelBookingSuccess extends CancelBookingState {
  final String message;
  CancelBookingSuccess(this.message);
}

class CancelBookingFailure extends CancelBookingState {
  final String error;
  CancelBookingFailure(this.error);
}
