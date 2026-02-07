import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_booking_tab/data/booking_user_repo.dart';
import 'package:marakiib_app/features/user_booking_tab/view_model/user_booking_state.dart';

class BookingUserCubit extends Cubit<BookingUserState> {
  final BookingUserRepository repository;

  BookingUserCubit(this.repository) : super(BookingUserInitial());

  Future<void> fetchUserBookings() async {
    if (isClosed) return;
    emit(BookingUserLoading());
    try {
      final bookings = await repository.getBookings();
      emit(BookingUserSuccess(bookings));
    } catch (e) {
      if (isClosed) return;
      emit(BookingUserFailure(e.toString()));
    }
  }
}
