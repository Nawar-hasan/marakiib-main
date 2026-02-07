import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/repository/popular_car_repo.dart';
import 'package:marakiib_app/features/user_home/view/widgets/popular_car_card.dart';
import 'package:marakiib_app/features/user_home/view_model/popular_cars_cubit/popular_cars_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/popular_cars_cubit/popular_cars_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class PopularCarList extends StatelessWidget {
  const PopularCarList({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create:
          (context) =>
              PopularCarCubit(PopularCarRepo(dio: Dio()))..fetchPopularCars(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate.popularCar,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   'View All',
                //   style: Theme.of(
                //     context,
                //   ).textTheme.titleSmall!.copyWith(color: AppTheme.primary),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 350.h,
            child: BlocConsumer<PopularCarCubit, PopularCarState>(
              listener: (context, state) {
                if (state is PopularCarError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PopularCarLoading) {
                  return const LoadingIndicator();
                } else if (state is PopularCarLoaded) {
                  if (state.popularcars.isEmpty) {
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
                    itemCount: state.popularcars.length,
                    itemBuilder:
                        (context, index) =>
                            PopularCarCard(car: state.popularcars[index]),
                  );
                } else if (state is PopularCarError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
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
