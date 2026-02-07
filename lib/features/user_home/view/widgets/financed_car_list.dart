import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/repository/financed_cars.dart';
import 'package:marakiib_app/features/user_home/view/widgets/financed_card.dart';
import 'package:marakiib_app/features/user_home/view_model/financed_cars_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/financed_cars_state.dart';

class FinancedCarList extends StatelessWidget {
  const FinancedCarList({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider(
      create:
          (context) => CarsCubit(CarsService(dio: Dio()))..getFinancedCars(),
      child: BlocBuilder<CarsCubit, CarsState>(
        builder: (context, state) {
          if (state is CarsLoading) {
            return const SizedBox.shrink();
          }

          if (state is CarsError) {
            return const SizedBox.shrink();
          }

          if (state is CarsLoaded && state.cars.isEmpty) {
            return const SizedBox.shrink();
          }

          if (state is CarsLoaded) {
            final cars = state.cars;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    translate.financedCars,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 300.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: cars.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return FinancedCarCard(car: cars[index]);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
