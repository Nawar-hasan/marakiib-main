import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class BookingInvoiceDialog extends StatelessWidget {
  final String? basePrice;
  final String? commissionAmount;
  final int? pickupDelivery;
  final String? pickupDeliveryPrice;
  final String total;

  const BookingInvoiceDialog({
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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.invoiceDetails,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Base Price
            _buildInvoiceRow(
              l10n.basePrice,
              '${basePrice ?? '0'} ${l10n.currency}',
              false,
            ),
            SizedBox(height: 12.h),

            // Commission
            _buildInvoiceRow(
              l10n.commissionAmount,
              '${commissionAmount ?? '0'} ${l10n.currency}',
              false,
            ),
            SizedBox(height: 12.h),

            // Pickup & Delivery (if applicable)
            if (pickupDelivery == 1) ...[
              _buildInvoiceRow(
                l10n.pickupAndDelivery,
                '${pickupDeliveryPrice ?? '0'} ${l10n.currency}',
                false,
              ),
              SizedBox(height: 12.h),
            ],

            Divider(color: Colors.grey[300], thickness: 2),
            SizedBox(height: 12.h),

            // Total
            _buildInvoiceRow(l10n.totalPrice, '$total ${l10n.currency}', true),
          ],
        ),
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
            fontSize: isTotal ? 18.sp : 15.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppTheme.primary : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 15.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primary : Colors.black87,
          ),
        ),
      ],
    );
  }
}
