import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class CarAvailabilityWidget extends StatelessWidget {
  final String availabilityStart;
  final String availabilityEnd;

  const CarAvailabilityWidget({
    super.key,
    required this.availabilityStart,
    required this.availabilityEnd,
  });

  String _formatDate(String dateString, BuildContext context) {
    try {
      final date = DateTime.parse(dateString);
      final locale = Localizations.localeOf(context);
      return DateFormat('dd MMM yyyy', locale.languageCode).format(date);
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  int _getDaysDifference() {
    try {
      final startDate = DateTime.parse(availabilityStart);
      final endDate = DateTime.parse(availabilityEnd);
      return endDate.difference(startDate).inDays + 1; // +1 to include both start and end days
    } catch (e) {
      return 0;
    }
  }

  String _getDaysText(int days, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (days == 1) {
      return localizations.oneDay ?? 'يوم واحد';
    } else if (days == 2) {
      return localizations.twoDays ?? 'يومان';
    } else if (days <= 10) {
      return localizations.fewDays(days.toString()) ?? '$days أيام';
    } else {
      return localizations.manyDays(days.toString()) ?? '$days يوماً';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final daysDifference = _getDaysDifference();
    final isAvailable = daysDifference > 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isAvailable ? Icons.calendar_month : Icons.calendar_month_outlined,
                color: AppTheme.black,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                localizations.availabilityPeriod ?? 'فترة التوفر',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray2
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.from ?? 'من',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _formatDate(availabilityStart, context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 2.w,
                height: 20.h,
                color: AppTheme.primary,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.to ?? 'إلى',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _formatDate(availabilityEnd, context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isAvailable) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${localizations.availableFor ?? 'متاح لمدة'} ${_getDaysText(daysDifference, context)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ] else ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                localizations.notAvailable ?? 'غير متاح حالياً',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
