import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/generated/app_localizations.dart'; // ⬅️ مهم
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/features/vendor_home/view_model/delete_car.dart';

class VendorDetailsButtons extends StatelessWidget {
  final VendorCarModel car;

  const VendorDetailsButtons({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!; // ⬅️ هنا هنسحب الترجمات

    return BlocProvider(
      create: (context) => DeleteCarCubit(),
      child: BlocConsumer<DeleteCarCubit, DeleteCarState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(translate.carDeletedSuccessfully)),
            );
            context.go('/VendorNavBarView');
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              children: [
                MyCustomButton(
                  text: translate.editNow, // ⬅️ بدل Edit Now
                  voidCallback: () {
                    context.push(AppRoutes.EditCarScreen, extra: car);
                  },
                  color: AppTheme.primary,
                  textColor: AppTheme.white,
                  height: 54.h,
                  width: double.infinity,
                  fontSize: 18.sp,
                  icon: Icon(
                    Icons.edit_square,
                    size: 26.sp,
                    color: AppTheme.white,
                  ),
                ),
                SizedBox(height: 16.h),
                MyCustomButton(
                  text: translate.deleteCar, // ⬅️ بدل Delete car
                  voidCallback:
                      state.isLoading
                          ? () {}
                          : () {
                            context.read<DeleteCarCubit>().deleteCar(car.id);
                          },
                  color: AppTheme.white,
                  textColor: AppTheme.primary,
                  height: 54.h,
                  width: double.infinity,
                  fontSize: 18.sp,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    size: 26.sp,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
