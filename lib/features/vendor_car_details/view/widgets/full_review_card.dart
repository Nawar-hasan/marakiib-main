import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';

class FullReviewCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String date;
  final int rating;
  final String review;

  const FullReviewCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.date,
    required this.rating,
    required this.review,
  });

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
              CircleImage(radius: 18, imageUrl: imagePath),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                date,
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
                    index < rating
                        ? AppTheme.secondaryPrimary
                        : AppTheme.gray100,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            review,
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
