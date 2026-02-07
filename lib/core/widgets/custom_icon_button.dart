import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double width;
  final double height;
  final Color iconColor;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 27,
    this.iconColor = AppTheme.black,
    this.backgroundColor,
    this.boxShadow,
    this.height = 40,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow:
              boxShadow ??
              [BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 4.r)],
        ),
        child: Center(child: Icon(icon, size: size.sp, color: iconColor)),
      ),
    );
  }
}
