import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_transactions/data/booking_repo.dart';
import 'package:marakiib_app/features/vendor_transactions/data/models/transaction_car_model.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_cubit.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository repository;

  BookingCubit(this.repository) : super(BookingInitial());

  Future<void> fetchBookings() async {
    if (isClosed) return;
    emit(BookingLoading());

    try {
      final bookings = await repository.getBookings();
      if (isClosed) return;
      emit(BookingSuccess(bookings));
    } catch (e) {
      if (isClosed) return;
      emit(BookingFailure(e.toString()));
    }
  }
}
