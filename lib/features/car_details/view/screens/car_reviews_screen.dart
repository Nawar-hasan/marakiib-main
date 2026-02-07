import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';
import 'package:marakiib_app/features/car_details/data/repository/add_review_repo.dart';
import 'package:marakiib_app/features/car_details/view/widgets/buttom_sheet.dart';
import 'package:marakiib_app/features/car_details/view/widgets/full_review_card.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/add_review_cubit.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CarReviewsScreen extends StatelessWidget {
  final CarDetailsModel carDetailsModel;
  const CarReviewsScreen({super.key, required this.carDetailsModel});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ).copyWith(bottom: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                icon: Icons.arrow_back,
                onTap: () => context.pop(),
                backgroundColor: Colors.transparent,
                boxShadow: [BoxShadow(color: Colors.transparent)],
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: AppTheme.secondaryPrimary),
                  SizedBox(width: 8.w),
                  Text(
                    '${translate.reviews(carDetailsModel.reviews.length)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView.builder(
                  itemCount: carDetailsModel.reviews.length,
                  itemBuilder: (context, index) {
                    return FullReviewCard(
                      reviewModel: carDetailsModel.reviews[index],
                    );
                  },
                ),
              ),
              MyCustomButton(
                icon: Icon(Icons.edit, color: AppTheme.white, size: 26.sp),
                text: translate.writeReview,
                width: double.infinity,
                height: 50.h,
                radius: 6.r,
                fontSize: 18.sp,
                voidCallback: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return BlocProvider(
                        create:
                            (_) => AddReviewCubit(
                              reviewRepo: AddReviewRepo(dio: Dio()),
                            ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: WriteReviewBottomSheet(
                            carId: carDetailsModel.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
