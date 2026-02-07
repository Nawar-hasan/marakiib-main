import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_financings/data/financed_cars_repository.dart';
import 'package:marakiib_app/features/vendor_financings/view/widgets/financing_card.dart';
import 'package:marakiib_app/features/vendor_financings/view_model/financed_cars_cubit.dart';
import 'package:marakiib_app/features/vendor_financings/view_model/financed_cars_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyFinancingsScreen extends StatelessWidget {
  const MyFinancingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create:
          (_) =>
              FinancedCarsCubit(FinancedCarsRepository(Dio()))
                ..fetchFinancedCars(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.myFinancings), centerTitle: true,backgroundColor: AppTheme.white,),
        body: BlocConsumer<FinancedCarsCubit, FinancedCarsState>(
          listener: (context, state) {
            if (state is FinancedCarsFailure) {
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
            if (state is FinancedCarsLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is FinancedCarsFailure) {
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

            if (state is FinancedCarsSuccess) {
              final financings = state.financedCars;

              if (financings.isEmpty) {
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
                        SizedBox(height: 16.h),
                        Text(
                          l10n.noFinancingsFound,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
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
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList.separated(
                        itemCount: financings.length,
                        itemBuilder: (context, index) {
                          final financing = financings[index];
                          return FinancingCard(financing: financing);
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
      ),
    );
  }
}
