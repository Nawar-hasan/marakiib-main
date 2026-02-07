import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_subscription/data/subscription_repository.dart';
import 'package:marakiib_app/features/vendor_subscription/view_model/subscription_cubit.dart';
import 'package:marakiib_app/features/vendor_subscription/view_model/subscription_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('yyyy-MM-dd');

    return BlocProvider(
      create:
          (_) =>
              SubscriptionCubit(SubscriptionRepository(Dio()))
                ..fetchMySubscription(),
      child: Scaffold(
        backgroundColor: AppTheme.gray1,
        appBar: AppBar(
          title: Text(l10n.mySubscription),
          centerTitle: true,
          backgroundColor: AppTheme.white,
        ),
        body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
          listener: (context, state) {
            if (state is SubscriptionFailure) {
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
            if (state is SubscriptionLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is SubscriptionFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.sp,
                      color: Colors.red.shade400,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is SubscriptionSuccess) {
              final subscription = state.subscription;
              final plan = subscription.plan;

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Monthly Subscription Header
                      Text(
                        l10n.monthlySubscription,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Subscription Card
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Plan Name
                              _buildInfoRow(
                                context,
                                l10n.subscriptionPlan,
                                plan?.planName.toUpperCase() ?? 'N/A',
                                Icons.card_membership,
                              ),
                              SizedBox(height: 16.h),
                              Divider(color: Colors.grey[300]),
                              SizedBox(height: 16.h),

                              // Max Cars
                              _buildInfoRow(
                                context,
                                l10n.maxCars,
                                '${plan?.maxCars ?? 0} ${l10n.cars}',
                                Icons.directions_car,
                              ),
                              SizedBox(height: 16.h),

                              // Current Cars Count
                              _buildInfoRow(
                                context,
                                l10n.currentCars,
                                '${subscription.carsCount} ${l10n.cars}',
                                Icons.car_rental,
                              ),
                              SizedBox(height: 16.h),
                              Divider(color: Colors.grey[300]),
                              SizedBox(height: 16.h),

                              // Start Date
                              _buildInfoRow(
                                context,
                                l10n.startDate,
                                dateFormat.format(subscription.startDate),
                                Icons.calendar_today,
                              ),
                              SizedBox(height: 16.h),

                              // End Date
                              _buildInfoRow(
                                context,
                                l10n.endDate,
                                dateFormat.format(subscription.endDate),
                                Icons.event,
                              ),
                              SizedBox(height: 16.h),

                              // Duration
                              _buildInfoRow(
                                context,
                                l10n.duration,
                                '${plan?.duration ?? 0} ${l10n.days}',
                                Icons.timelapse,
                              ),
                              SizedBox(height: 20.h),
                              Divider(color: Colors.grey[300], thickness: 2),
                              SizedBox(height: 20.h),

                              // Subscription Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.subscriptionPrice,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                  Text(
                                    '${plan?.price ?? '0'} ${l10n.currency}',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppTheme.primary),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
