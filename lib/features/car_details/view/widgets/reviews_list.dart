import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';
import 'package:marakiib_app/features/car_details/view/widgets/review_card.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class ReviewsList extends StatelessWidget {
  final CarDetailsModel carDetailsModel;
  const ReviewsList({super.key, required this.carDetailsModel});

  @override
  Widget build(BuildContext context) {
    final reviews = carDetailsModel.reviews;
    final translate = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 16.w,
          ).copyWith(top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${translate.reviews(reviews.length)}',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppTheme.black),
              ),
              InkWell(
                onTap: () {
                  context.push(
                    AppRoutes.CarReviewsScreen,
                    extra: carDetailsModel,
                  );
                },
                child: Text(
                  translate.viewAll,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: AppTheme.primary),
                ),
              ),
            ],
          ),
        ),
        if (reviews.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text(
                translate.noReviewsYet,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 130.h,
            child: ListView.builder(
              itemCount: reviews.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:
                  (context, index) => ReviewCard(reviewModel: reviews[index]),
            ),
          ),
      ],
    );
  }
}
