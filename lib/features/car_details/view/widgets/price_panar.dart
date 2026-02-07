import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class PricePanar extends StatelessWidget {
  final String price;
  final int carId;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;
  final String? plateType;

  const PricePanar({
    super.key,
    required this.price,
    required this.carId,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
    this.plateType,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Text(
            '$price\JOD/',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 26.sp,
            ),
          ),
          Text(
            translate.day,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.gray400,
            ),
          ),
          const Spacer(),
          MyCustomButton(
            text: translate.rentNow,
            width: 140.w,
            height: 50.h,
            radius: 6.r,
            fontSize: 18.sp,
            voidCallback: () {
              context.push(
                '/BookingDetailsScreen',
                extra: {
                  'carId': carId,
                  'rentalPrice': price,
                  'pickupDelivery': pickupDelivery,
                  'pickupDeliveryPrice': pickupDeliveryPrice,
                  'commissionValue': commissionValue,
                  'commissionType': commissionType,
                  'plateType': plateType,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
