import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';

import 'package:marakiib_app/generated/app_localizations.dart';

class CarDetailsInfo extends StatelessWidget {
  final VendorCarModel car;

  const CarDetailsInfo({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car.nameEn ?? 'Unknown Car',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  car.description ?? 'No description available.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppTheme.gray200,
                    fontSize: 14.sp,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 90.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: car.isActive
                      ? Color(0xff22C55E).withAlpha(110)
                      : Colors.grey.withAlpha(110),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Center(
                  child: Text(
                    car.isActive ? t.available : t.unavailable,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: car.isActive ? Colors.green[900] : Colors.grey[900],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
