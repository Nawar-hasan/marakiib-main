import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../themeing/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, right: 8.w, top: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.push('/');
              }
            },
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppTheme.blueLight2,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: AppTheme.black, size: 18.sp),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer(),
          actionIcon != null
              ? IconButton(
            icon: Icon(
              actionIcon,
              color: AppTheme.primary,
            ),
            onPressed: onActionTap,
          )
              : SizedBox(width: 32.w),
        ],
      ),
    );
  }
}
