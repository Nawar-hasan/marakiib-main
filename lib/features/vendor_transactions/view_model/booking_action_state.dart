
abstract class BookingActionState {}

class BookingActionInitial extends BookingActionState {}

class BookingActionLoading extends BookingActionState {}

class BookingActionSuccess extends BookingActionState {
  final int bookingId;
  final bool confirmed;
  BookingActionSuccess(this.bookingId, this.confirmed);
}

class BookingActionFailure extends BookingActionState {
  final String error;
  BookingActionFailure(this.error);
}
