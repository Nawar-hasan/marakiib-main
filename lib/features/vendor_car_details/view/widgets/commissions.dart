import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/localization/language_state.dart';
import 'package:marakiib_app/core/localization/localization_bloc.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_car_details/view/data/commissions_model.dart';
import 'package:marakiib_app/features/vendor_car_details/view_model/commissions_cubit.dart';
import 'package:marakiib_app/features/vendor_car_details/view_model/commissions_state.dart';

class CommissionDescriptionWidget extends StatelessWidget {
  final String appliesTo;
  final String? plateType;

  const CommissionDescriptionWidget({
    super.key,
    required this.appliesTo,
    required this.plateType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommissionCubit()..getCommissions(),
      child: BlocBuilder<CommissionCubit, CommissionState>(
        builder: (context, state) {
          if (state is CommissionLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is CommissionError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppTheme.primary),
              ),
            );
          }

          if (state is CommissionSuccess) {
            final List<CommissionModel> filtered = state.commissions.where((c) {
              final bool appliesMatch =
                  c.appliesTo == appliesTo || c.appliesTo == 'both';
              final bool plateMatch = c.plateType == plateType;
              return appliesMatch && plateMatch;
            }).toList();

            if (filtered.isEmpty) {
              return const SizedBox.shrink();
            }

            final CommissionModel selected = filtered.first;

            return BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, langState) {
                final bool isArabic = langState.languageCode == 'ar';
                final String description = isArabic
                    ? selected.descriptionAr
                    : selected.descriptionEn;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppTheme.blueLight2,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppTheme.primary, width: 1.2),
                  ),
                  child: Text(
                    description,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
