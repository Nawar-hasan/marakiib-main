import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/booking_screen/view_model/cancel_booking_cubit.dart';
import 'package:marakiib_app/features/booking_screen/view_model/cancel_booking_state.dart';
import 'package:marakiib_app/features/user_booking_tab/data/models/booking_car_model.dart';
import 'package:marakiib_app/features/user_booking_tab/view_model/user_booking_cubit.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/widgets/booking_invoice_section.dart';

class CarBookingCard extends StatefulWidget {
  final BookingUserModel booking;

  const CarBookingCard({super.key, required this.booking});

  @override
  State<CarBookingCard> createState() => _CarBookingCardState();
}

class _CarBookingCardState extends State<CarBookingCard> {
  bool _isExpanded = false;

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String getTranslatedStatus(String status, AppLocalizations translate) {
    final Map<String, String> statusMap = {
      'pending': translate.pending,
      'confirmed': translate.confirmed,
      'rejected': translate.rejected,
      'cancelled': translate.cancelled,
    };
    return statusMap[status.toLowerCase()] ?? status;
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final translatedStatus = getTranslatedStatus(
      widget.booking.status,
      translate,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                /// Car Image
                Image.network(
                  widget.booking.imageUrl,
                  width: 120.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Image.asset(
                        "assets/images/car.png",
                        width: 120.w,
                        height: 90.h,
                      ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Car Name + Model
                      Text(
                        "${widget.booking.carName}${widget.booking.carModel != null ? ' - ${widget.booking.carModel}' : ''}",
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),

                      /// Plate Type
                      if (widget.booking.plateType != null)
                        Text(
                          "${translate.plateType}: ${widget.booking.plateType}",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.gray900),
                        ),

                      /// Owner Name
                      Text(
                        "${translate.owner}: ${widget.booking.ownerName}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.gray900,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      /// Dates
                      Text(
                        "${translate.from} ${_formatDate(widget.booking.startDate)}  ${translate.to}: ${_formatDate(widget.booking.endDate)}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.gray900,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      /// Total Price with expand icon
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${translate.total}: \JOD${widget.booking.total}",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppTheme.primary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),

                      /// Status
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12.sp,
                            color: getStatusColor(widget.booking.status),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            translatedStatus,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: getStatusColor(widget.booking.status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// Invoice Section (Expandable)
            if (_isExpanded)
              BookingInvoiceSection(
                basePrice: widget.booking.basePrice,
                commissionAmount: widget.booking.commissionAmount,
                pickupDelivery: widget.booking.pickupDelivery,
                pickupDeliveryPrice: widget.booking.pickupDeliveryPrice,
                total: widget.booking.total,
              ),

            /// Cancel Button لو الحالة pending
            if (widget.booking.status.toLowerCase() == "pending") ...[
              SizedBox(height: 8.h),
              BlocConsumer<CancelBookingCubit, CancelBookingState>(
                listener: (context, state) {
                  if (state is CancelBookingSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    context.read<BookingUserCubit>().fetchUserBookings();
                  } else if (state is CancelBookingFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is CancelBookingLoading) {
                    return const Center(child: LoadingIndicator());
                  }
                  return MyCustomButton(
                    text: translate.cancelBooking,
                    voidCallback: () {
                      context.read<CancelBookingCubit>().cancelBooking(
                        widget.booking.id,
                      );
                    },
                    color: Colors.red,
                    borderColor: Colors.red,
                    textColor: Colors.white,
                    width: 140,
                    height: 36,
                    radius: 8,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _formatDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return isoDate;
  }
}
