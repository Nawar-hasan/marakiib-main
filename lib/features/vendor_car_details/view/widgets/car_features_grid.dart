import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';


class CarFeaturesGrid extends StatelessWidget {
  final VendorCarModel car;

  const CarFeaturesGrid({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final features = [
      {
        'title': 'Type of insurance',
        'value': car.insuranceType ?? 'Unknown',
        'icon': 'assets/images/power.png',
      },
      {
        'title': 'Engine type',
        'value': car.engineType ?? 'Unknown',
        'icon': 'assets/images/vector.png',
      },
      {
        'title': 'Nature of use',
        'value': car.usageNature ?? 'Unknown',
        'icon': 'assets/images/rpm.png',
      },
      {
        'title': 'Fuel Type',
        'value': car.fuelType ?? 'Unknown',
        'icon': 'assets/images/vector.png',
      },
      {
        'title': 'Transmission',
        'value': car.transmission ?? 'Unknown',
        'icon': 'assets/images/vector.png',
      },
      {
        'title': 'Seats',
        'value': '${car.capacity ?? 0}',
        'icon': 'assets/images/vector.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 16.w,
          ).copyWith(bottom: 25.h),
          child: Text(
            l10n.carfeatures,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            return Container(
              height: 90.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppTheme.gray1010,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Image.asset(
                      features[index]['icon'] != null && features[index]['icon']!.isNotEmpty
                          ? features[index]['icon']!
                          : 'assets/images/vector.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/vector.png',
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    features[index]['title']!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12.sp,
                      color: AppTheme.gray200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    features[index]['value']!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
