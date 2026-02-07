import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themeing/app_theme.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.text,
    required this.voidCallback,
    this.width = 161,
    this.height = 37,
    this.radius = 10,
    this.fontSize = 14,
    this.color = AppTheme.primary,
    this.textColor = AppTheme.white,
    this.borderColor = AppTheme.primary,
    this.icon,
  });

  final String text;
  final VoidCallback voidCallback;
  final double width;
  final double height;
  final double radius;
  final double fontSize;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 6.w)],
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
