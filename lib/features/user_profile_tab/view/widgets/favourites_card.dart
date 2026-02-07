import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/view/widgets/popular_car_card.dart';
import 'package:marakiib_app/features/user_profile_tab/data/favourites_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class FavouriteCarCard extends StatelessWidget {
  final FavouriteModel car;
  final VoidCallback onRent;

  const FavouriteCarCard({
    super.key,
    required this.car,
    required this.onRent,
  });

  @override
  Widget build(BuildContext context) {
     final translate = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.CarDetailsScreen, extra: car.car.id);
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
              car.car.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (car.car.categories.isNotEmpty)
              Text(
                car.car.categories[0].name,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            SizedBox(height: 2.h),
            Center(
              child: CachedNetworkImage(
                imageUrl: car.car.mainImage,
                height: 100.h,
                width: 128.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  height: 100.h,
                  width: 128.w,
                  child: LoadingIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 14,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                if (car.car.features.length > 0)
                  InfoItem(icon: Icons.settings_input_composite, label: car.car.features[0].value),
                if (car.car.features.length > 1)
                  InfoItem(icon: Icons.settings, label: car.car.features[1].value),
                if (car.car.features.length > 2)
                  InfoItem(icon: Icons.people, label: '${car.car.features[2].value} Seats'),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              '${car.car.rentalPrice}\JOD',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            MyCustomButton(
              text: translate.rentNow,
              width: double.infinity,
              radius: 6.r,
              height: 35.h,
              voidCallback: onRent,
            ),
          ],
        ),
      ),
    );
  }
}
