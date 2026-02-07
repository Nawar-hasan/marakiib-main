import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';

class CongratulationsBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;
  final String imagePath;

  const CongratulationsBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            // Image.asset(imagePath, height: 80.h),
            // SizedBox(height: 15.h),
            // Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 10.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppTheme.gray2),
            ),
            SizedBox(height: 20.h),
            MyCustomButton(
              text: "Done",
              voidCallback: () {
                context.push('/VendorNavBarView');
              },
              width: double.infinity,
              height: 54.h,
              fontSize: 16.sp,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
