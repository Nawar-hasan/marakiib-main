import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class nav_Icon extends StatelessWidget {
  final String assetPath;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  const nav_Icon({
    super.key,
    required this.assetPath,
    required this.isActive,

    this.size = 26,

    this.inactiveColor = AppTheme.white,
    this.activeColor = AppTheme.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(assetPath),
      size: size.sp,
      color: isActive ? activeColor : inactiveColor,
    );
  }
}
