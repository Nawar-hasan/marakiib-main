import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5.r),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppTheme.gray400),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: translate.searchSomethingHere,
                hintStyle: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppTheme.gray400),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
