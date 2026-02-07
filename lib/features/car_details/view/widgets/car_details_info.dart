import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CarDetailsInfo extends StatelessWidget {
  final String name;
  final String description;
  final bool isActive;
  final bool isOffice;

  const CarDetailsInfo({
    super.key,
    required this.name,
    required this.description,
    required this.isActive,
    this.isOffice = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // لجلب الترجمة

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppTheme.gray200,
                    fontSize: 14.sp,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  Container(
                    width: 90.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? Color(0xff22C55E).withAlpha(110)
                              : Colors.grey.withAlpha(110),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        isActive ? t.available : t.unavailable,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color:
                              isActive ? Colors.green[900] : Colors.grey[900],
                        ),
                      ),
                    ),
                  ),
                  if (isOffice) ...[
                    SizedBox(height: 4.h),
                    Text(
                      t.touristOffice,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
