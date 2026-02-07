import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';

class WriteReviewBottomSheet extends StatelessWidget {
  const WriteReviewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Text(
                'What is you rate?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      Icons.star_border,
                      color: AppTheme.black,
                      size: 32.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Please share your opinion\nabout the product',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Your review',
                  filled: true,
                  fillColor: AppTheme.tertiary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppTheme.tertiary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.primary,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppTheme.white,
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Add your photos',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              MyCustomButton(
                text: 'SEND REVIEW',
                width: double.infinity,
                height: 50.h,
                radius: 6.r,
                fontSize: 18.sp,
                voidCallback: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
