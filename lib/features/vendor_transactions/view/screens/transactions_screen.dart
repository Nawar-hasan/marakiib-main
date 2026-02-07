import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_transactions/data/booking_repo.dart';
import 'package:marakiib_app/features/vendor_transactions/view/widgets/transactions_card.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_cubit.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:marakiib_app/generated/app_localizations.dart';


class TransactionsTabScreen extends StatelessWidget {
  const TransactionsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => BookingCubit(BookingRepository(Dio()))..fetchBookings(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.error,
                backgroundColor: Colors.red.shade700,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is BookingFailure) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            );
          }

          if (state is BookingSuccess) {
            final bookings = state.bookings;

            if (bookings.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Lottie.asset(
                        'assets/images/booking.json',
                        height: 200.h,
                        width: 200.w,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        translate.noBookingsFound,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          translate.myBookings,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverList.separated(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        return TransactionsCard(transactionCarModel: booking);
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
