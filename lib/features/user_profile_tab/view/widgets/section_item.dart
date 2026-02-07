import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themeing/app_theme.dart';

class SectionItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const SectionItem({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.gray1010, width: 1),
              ),
              padding: EdgeInsets.all(4.r),
              child: Icon(
                icon,
                size: 20.sp,
                color: AppTheme.gray2,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppTheme.black,
              ),
            ),
            const Spacer(),
             Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
              color: AppTheme.gray2,
            ),
          ],
        ),
      ),
    );
  }
}
