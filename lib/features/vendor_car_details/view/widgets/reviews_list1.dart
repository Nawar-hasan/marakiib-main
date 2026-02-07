import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/car_details/view/widgets/review_card.dart';
import 'package:marakiib_app/features/vendor_car_details/view/data/reviews_car_model.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/review_card.dart';

class ReviewsList1 extends StatelessWidget {
  final List<CarReviewModel> reviews;

  const ReviewsList1({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
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
                'Review (${reviews.length})',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppTheme.black),
              ),
              // InkWell(
              //   onTap: () {
              //     context.push(AppRoutes.CarReviewsScreen);
              //   },
              //   child: Text(
              //     'View All',
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleSmall!
              //         .copyWith(color: AppTheme.primary),
              //   ),
              // ),
            ],
          ),
        ),

        SizedBox(
          height: 130.h,
          child: ListView.builder(
            itemCount: reviews.length > 6 ? 6 : reviews.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewCard1(
                name: review.customerName,
                review: review.comment,
                rating: review.rating.toDouble(),
                imageUrl: review.customerAvatar ?? 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
              );
            },
          ),
        ),
      ],
    );
  }
}
