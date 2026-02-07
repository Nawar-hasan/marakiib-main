import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

class FullReviewCard extends StatelessWidget {
  final ReviewModel reviewModel;

  const FullReviewCard({super.key, required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppTheme.gray100),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gray400.withAlpha(50),
            blurRadius: 6.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleImage(
                radius: 18,
                imageUrl:
                    reviewModel.user.avatar ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgLoEr-JlJN24dbA60WJJeL8BUfJF2L86obx4Vq5b7hu0lDVlgDqO-O770OGw-Ac3-xm4&usqp=CAU',
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  reviewModel.user.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                DateFormat('dd MMM, yyyy').format(reviewModel.createdAt),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                  color: AppTheme.gray400,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                size: 18.sp,
                color:
                    index < reviewModel.rating
                        ? AppTheme.secondaryPrimary
                        : AppTheme.gray100,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            reviewModel.comment,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.normal,
              color: AppTheme.gray901,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
