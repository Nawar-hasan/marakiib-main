import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/features/user_home/view/widgets/car_available_card.dart';
import 'package:marakiib_app/features/user_home/view_model/cars_available_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/cars_available_state.dart';

class CarsAvailableList extends StatelessWidget {
  const CarsAvailableList({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) =>
      CarsAvailableCubit()..getCarsAvailable(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate.carsAvailable,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 350.h,
            child: BlocConsumer<CarsAvailableCubit, CarsAvailableState>(
              listener: (context, state) {
                if (state is CarsAvailableFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CarsAvailableLoading) {
                  return const LoadingIndicator();
                } else if (state is CarsAvailableSuccess) {
                  if (state.cars.isEmpty) {
                    return Center(
                      child: Text(
                        translate.noCarsAvailable,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    itemCount: state.cars.length,
                    itemBuilder: (context, index) =>
                        CarsAvailableCard(car: state.cars[index]),
                  );
                } else if (state is CarsAvailableFailure) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
