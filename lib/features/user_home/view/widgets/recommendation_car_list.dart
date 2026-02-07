import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/repository/recommended_car_repo.dart';
import 'package:marakiib_app/features/user_home/view/widgets/recomendation_car_card.dart';
import 'package:marakiib_app/features/user_home/view_model/recommended_cars_cubit/recommended_cars_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/recommended_cars_cubit/recommended_cars_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class RecommendationCarList extends StatelessWidget {
  const RecommendationCarList({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create:
          (context) => RecommendedCarsCubit(
            recommendedCarRepo: RecommendedCarRepo(dio: Dio()),
          )..getRecommendedCars(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate.recommendationCars,
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
            child: BlocConsumer<RecommendedCarsCubit, RecommendedCarState>(
              listener: (context, state) {
                if (state is RecommendedCarError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is RecommendedCarLoading) {
                  return const LoadingIndicator();
                } else if (state is RecommendedCarLoaded) {
                  final cars = state.recommendedCars ?? [];
                  if (cars.isEmpty) {
                    return Center(
                      child: Text(
                        translate.noRecommendedCarsAvailable,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),

                    scrollDirection: Axis.horizontal,
                    itemCount: cars.length,
                    itemBuilder:
                        (context, index) => RecomendationCarCard(
                          car: cars[index],
                          onRent: () {},
                        ),
                  );
                } else if (state is RecommendedCarError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: const TextStyle(color: Colors.red),
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
