import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/vendor_financings/data/models/financed_car_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class FinancingCard extends StatelessWidget {
  final FinancedCarModel financing;

  const FinancingCard({super.key, required this.financing});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image and Name
            Row(
              children: [
                // Car Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: financing.carImage,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          width: 80.w,
                          height: 80.h,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          width: 80.w,
                          height: 80.h,
                          color: Colors.grey[300],
                          child: Icon(Icons.car_rental, size: 40.sp),
                        ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Car Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.financedCar,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        financing.carName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 12.h),

            // Financing Duration
            _buildInfoRow(
              l10n.financingDuration,
              '${financing.days} ${l10n.days}',
              Icons.calendar_today,
            ),
            SizedBox(height: 8.h),

            // Start Date
            _buildInfoRow(
              l10n.startDate,
              dateFormat.format(financing.startDate),
              Icons.play_arrow,
            ),
            SizedBox(height: 8.h),

            // End Date
            _buildInfoRow(
              l10n.endDate,
              dateFormat.format(financing.endDate),
              Icons.stop,
            ),

            if (financing.plan != null) ...[
              SizedBox(height: 12.h),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 12.h),

              // Plan Name
              _buildInfoRow(
                l10n.planName,
                financing.plan!.name,
                Icons.description,
              ),
              SizedBox(height: 8.h),

              // Daily Price
              _buildInfoRow(
                l10n.dailyPrice,
                '${financing.plan!.dailyPrice} ${l10n.currency}',
                Icons.attach_money,
              ),
            ],

            SizedBox(height: 12.h),
            Divider(color: Colors.grey[300], thickness: 2),
            SizedBox(height: 12.h),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.totalPrice,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  '${financing.totalPrice} ${l10n.currency}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
