import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/models/car_available.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CarsAvailableCard extends StatelessWidget {
  final CarsAvailableModel car;

  const CarsAvailableCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.CarDetailsScreen, extra: car.id);
      },
      child: Container(
        width: 223.w,
        height: 235.h,
        margin: EdgeInsets.all(12.sp).copyWith(right: 4),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(120),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              car.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              car.categories.isNotEmpty
                  ? car.categories[0].name
                  : 'No Category',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: car.mainImage ?? 'https://via.placeholder.com/150',
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover, // <-- هنا
                  placeholder:
                      (context, url) => Container(
                        height: 120.h,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(child: LoadingIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.car_crash_outlined, size: 40),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  InfoItem(
                    icon: Icons.settings_input_composite,
                    label: car.engineType,
                  ),
                  InfoItem(
                    icon: Icons.settings,
                    label:
                        car.features.length > 1 ? car.features[1].value : 'N/A',
                  ),
                  InfoItem(
                    icon: Icons.people,
                    label:
                        car.features.length > 3
                            ? car.features[3].value
                            : 'N/A Seats',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${car.rentalPrice}\JOD',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        translate.day,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                MyCustomButton(
                  text: translate.rentNow,
                  width: 93.w,
                  height: 38.h,
                  radius: 6.r,
                  fontSize: 13.sp,
                  voidCallback: () {
                    context.push(
                      '/BookingDetailsScreen',
                      extra: {
                        'carId': car.id,
                        'rentalPrice': car.rentalPrice,
                        'pickupDelivery': car.pickupDelivery,
                        'pickupDeliveryPrice': car.pickupDeliveryPrice,
                        'commissionValue': car.commissionValue,
                        'commissionType': car.commissionType,
                        'plateType': car.plateType,
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blueGrey, size: 16.sp),
        SizedBox(width: 3.w),
        Text(label, style: TextStyle(color: Colors.blueGrey, fontSize: 12.sp)),
      ],
    );
  }
}
