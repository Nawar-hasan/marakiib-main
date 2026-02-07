import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/booking_screen/view_model/cancel_booking_cubit.dart';
import 'package:marakiib_app/features/user_booking_tab/data/booking_user_repo.dart';
import 'package:marakiib_app/features/user_booking_tab/view/widgets/booking_card.dart';
import 'package:marakiib_app/features/user_booking_tab/view_model/user_booking_cubit.dart';
import 'package:marakiib_app/features/user_booking_tab/view_model/user_booking_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class BookingTabScreen extends StatelessWidget {
  const BookingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  BookingUserCubit(BookingUserRepository(Dio()))
                    ..fetchUserBookings(),
        ),
        BlocProvider(create: (context) => CancelBookingCubit()),
      ],
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                translate.myBookings,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: BlocBuilder<BookingUserCubit, BookingUserState>(
                builder: (context, state) {
                  if (state is BookingUserLoading) {
                    return const Center(child: LoadingIndicator());
                  } else if (state is BookingUserSuccess) {
                    if (state.bookings.isEmpty) {
                      return Center(
                        child: Text(
                          translate.noBookingsFound,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.bookings.length,
                      itemBuilder: (context, index) {
                        return CarBookingCard(booking: state.bookings[index]);
                      },
                    );
                  } else if (state is BookingUserFailure) {
                    return Center(child: Text("Error: ${state.error}"));
                  }
                  return Center(child: Text(translate.noData));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
