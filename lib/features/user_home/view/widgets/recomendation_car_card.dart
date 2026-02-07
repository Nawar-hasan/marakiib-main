import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/models/recommended_car_model.dart';
import 'package:marakiib_app/features/user_home/view/widgets/popular_car_card.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class RecomendationCarCard extends StatelessWidget {
  final RecommendedCarModel car;
  final VoidCallback onRent;

  const RecomendationCarCard({
    super.key,
    required this.car,
    required this.onRent,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    // Add logging to debug car data
    // print(
    //   'Car ID: ${car.id}, Name: ${car.name}, Categories: ${car.categories?.length ?? 0}, Features: ${car.features?.length ?? 0}',
    // );

    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.CarDetailsScreen, extra: car.id);
      },
      child: Container(
        width: 170.w,
        margin: EdgeInsets.all(12.sp).copyWith(right: 4),
        padding: EdgeInsets.all(10.sp),
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
              car.name ?? "Unknown Car",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              (car.categories?.isNotEmpty ?? false)
                  ? car.categories![0].name
                  : "No Category",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 2.h),
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
            SizedBox(height: 12.h),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                const InfoItem(
                  icon: Icons.settings_input_composite,
                  label: "v4",
                ),
                InfoItem(
                  icon: Icons.settings,
                  label:
                      (car.features?.asMap().containsKey(1) ?? false)
                          ? car.features![1].value
                          : "N/A",
                ),
                InfoItem(
                  icon: Icons.people,
                  label:
                      (car.features?.asMap().containsKey(3) ?? false)
                          ? '${car.features![3].value} Seats'
                          : "N/A",
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              '${car.rentalPrice?.toStringAsFixed(2) ?? "N/A"}\JOD',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15.h),
            MyCustomButton(
              text: translate.rentNow,
              width: double.infinity,
              height: 38.h,
              radius: 6.r,
              fontSize: 13.sp,
              voidCallback: () {
                context.push(
                  '/BookingDetailsScreen',
                  extra: {
                    'carId': car.id,
                    'rentalPrice': car.rentalPrice.toString(),
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
      ),
    );
  }
}
