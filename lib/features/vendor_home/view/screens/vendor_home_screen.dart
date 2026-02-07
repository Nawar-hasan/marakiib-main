import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/features/vendor_home/view/widgets/vendor_car_card.dart';
import 'package:marakiib_app/features/vendor_home/view/widgets/vendor_cars_list.dart';
import 'package:marakiib_app/features/vendor_home/view/widgets/vendor_search_header.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              // const SliverToBoxAdapter(child: VendorSearchHeader()),
              const VendorCarsListScreen(), // Directly include VendorCarsListScreen
              SliverPadding(padding: EdgeInsets.only(bottom: 120.h)),
            ],
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 40.h,
            child: MyCustomButton(
              text: translate.uploadCarTitle,
              voidCallback: () {
                context.push(AppRoutes.UploadCarScreen);
              },
              color: AppTheme.white.withAlpha(230),
              textColor: AppTheme.primary,
              height: 54.h,
              fontSize: 18.sp,
              icon: Icon(
                Icons.cloud_upload_outlined,
                size: 26.sp,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
