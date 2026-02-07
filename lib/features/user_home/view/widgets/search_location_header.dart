import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/core/widgets/search_text_field.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_cubit.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_state.dart';
import 'package:marakiib_app/features/user_home/view/widgets/filter_buttom_sheet.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class SearchHeader extends StatelessWidget {
  SearchHeader({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location section
          // InkWell(
          //   onTap: () {
          //     context.push(AppRoutes.MapScreen);
          //   },
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.location_on_outlined,
          //         size: 20.sp,
          //         color: Colors.black,
          //       ),
          //       SizedBox(width: 6.w),
          //       Text(
          //         translate.location,
          //         style: Theme.of(context).textTheme.titleSmall,
          //       ),
          //       Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
          //     ],
          //   ),
          // ),
          SizedBox(height: 16.h),

          // Search and filter section
          Row(
            children: [
              // Search text field
              SearchTextField(
                hint: translate.searchSomethingHere,
                controller: controller,
                onChanged: (value) {
                  context.read<SearchCubit>().searchCars(query: value);
                },
              ),
              SizedBox(width: 12.w),

              // Filter button
              GestureDetector(
                onTap: () {
                  context.push('/SearchFilterPage');
                },
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                    color: AppTheme.white,
                  ),
                  child: Icon(Icons.tune, color: AppTheme.gray400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
