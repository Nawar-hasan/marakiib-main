import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel reviewModel;
  const ReviewCard({super.key, required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 280,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppTheme.black, width: 0.6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImage(
            radius: 24,
            imageUrl:
                reviewModel.user.avatar ??
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgLoEr-JlJN24dbA60WJJeL8BUfJF2L86obx4Vq5b7hu0lDVlgDqO-O770OGw-Ac3-xm4&usqp=CAU',
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        reviewModel.user.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${reviewModel.rating}',
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star,
                          color: AppTheme.secondaryPrimary,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  reviewModel.comment,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppTheme.gray200,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
