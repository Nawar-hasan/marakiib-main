import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class BookingInvoiceSection extends StatelessWidget {
  final String? basePrice;
  final String? commissionAmount;
  final int? pickupDelivery;
  final String? pickupDeliveryPrice;
  final String total;

  const BookingInvoiceSection({
    super.key,
    this.basePrice,
    this.commissionAmount,
    this.pickupDelivery,
    this.pickupDeliveryPrice,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            l10n.invoiceDetails,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
          SizedBox(height: 12.h),

          // Base Price
          _buildInvoiceRow(
            l10n.basePrice,
            '${basePrice ?? '0'} ${l10n.currency}',
            false,
          ),
          SizedBox(height: 8.h),

          // Commission
          _buildInvoiceRow(
            l10n.commissionAmount,
            '${commissionAmount ?? '0'} ${l10n.currency}',
            false,
          ),
          SizedBox(height: 8.h),

          // Pickup & Delivery (if applicable)
          if (pickupDelivery == 1) ...[
            _buildInvoiceRow(
              l10n.pickupAndDelivery,
              '${pickupDeliveryPrice ?? '0'} ${l10n.currency}',
              false,
            ),
            SizedBox(height: 8.h),
          ],

          Divider(color: Colors.grey[400]),
          SizedBox(height: 8.h),

          // Total
          _buildInvoiceRow(l10n.totalPrice, '$total ${l10n.currency}', true),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppTheme.primary : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primary : Colors.black87,
          ),
        ),
      ],
    );
  }
}
