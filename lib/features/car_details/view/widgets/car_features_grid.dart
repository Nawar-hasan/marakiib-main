import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';
import 'package:marakiib_app/features/user_home/data/models/recommended_car_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CarFeaturesGrid extends StatelessWidget {
  final List<FeatureModel> features;

  const CarFeaturesGrid({super.key, required this.features});
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 16.w,
          ).copyWith(bottom: 25.h),
          child: Text(
            translate.carFeatures,
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
                  Text(
                    features[index].featureName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 13.sp,
                      color: AppTheme.gray200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    features[index].value,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 16.sp),
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
