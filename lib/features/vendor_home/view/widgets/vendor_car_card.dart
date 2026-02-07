import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class VendorCarCard extends StatelessWidget {
  final VendorCarModel car;
  final VoidCallback onRent;

  const VendorCarCard({super.key, required this.car, required this.onRent});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutes.VendorCarDetailsScreen,
          extra: car,
        ); // Pass car to details screen
      },
      child: Container(
        width: 170.w,
        margin: EdgeInsets.all(12.sp).copyWith(right: 4),
        padding: EdgeInsets.all(8.sp),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    car.nameEn ?? "Unknown Car",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Implement more options (e.g., edit/delete car)
                //   },
                //   child: Icon(Icons.more_vert, size: 26.sp),
                // ),
              ],
            ),
            Text(
              car.color ?? "No color",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Container(
                height: 120.h, // بدل 40.h
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade100,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  car.image ?? "",
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => Center(
                        child: Icon(
                          Icons.directions_car,
                          size: 50.sp,
                          color: Colors.grey,
                        ),
                      ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: LoadingIndicator());
                  },
                ),
              ),
            ),

            SizedBox(height: 10.h),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                InfoItem(
                  icon: Icons.local_gas_station,
                  label: car.fuelType ?? "-",
                ),
                InfoItem(icon: Icons.settings, label: car.transmission ?? "-"),
                InfoItem(
                  icon: Icons.people,
                  label: "${car.capacity ?? 0} seats",
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              '${car.rentalPrice?.toStringAsFixed(2) ?? "0.00"}\JOD',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            MyCustomButton(
              text: translate.sponsored,
              width: double.infinity,
              radius: 6.r,
              height: 35.h,
              voidCallback: onRent, // Use the onRent callback
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
        Icon(icon, size: 16.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
