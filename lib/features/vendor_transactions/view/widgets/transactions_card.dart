import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_transactions/data/models/transaction_car_model.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_action_cubit.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_action_state.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/features/vendor_transactions/view_model/booking_cubit.dart';
import 'package:marakiib_app/core/widgets/booking_invoice_section.dart';

class TransactionsCard extends StatefulWidget {
  final BookingModel transactionCarModel;

  const TransactionsCard({super.key, required this.transactionCarModel});

  @override
  State<TransactionsCard> createState() => _TransactionsCardState();
}

class _TransactionsCardState extends State<TransactionsCard> {
  bool _isExpanded = false;

  // 🟢 دالة لتحديد لون الحالة
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'confirmed':
        return Colors.green;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // 🟢 دالة لترجمة الحالة
  String getTranslatedStatus(String status, AppLocalizations translate) {
    final Map<String, String> statusMap = {
      'pending': translate.pending,
      'confirmed': translate.confirmed,
      'rejected': translate.rejected,
      'completed': translate.completed,
      'cancelled': translate.cancelled,
    };
    return statusMap[status.toLowerCase()] ?? status;
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final local = AppLocalizations.of(context)!;
    final translatedStatus = getTranslatedStatus(
      widget.transactionCarModel.status,
      local,
    );

    return BlocProvider(
      create: (_) => BookingActionCubit(dio),
      child: BlocBuilder<BookingActionCubit, BookingActionState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16.r),
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
                      /// صورة السيارة
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child:
                            widget.transactionCarModel.imageUrl.startsWith(
                                  'http',
                                )
                                ? Image.network(
                                  widget.transactionCarModel.imageUrl,
                                  width: 90.w,
                                  height: 70.h,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                            'assets/images/car.png',
                                            width: 90.w,
                                            height: 70.h,
                                          ),
                                )
                                : Image.asset(
                                  widget.transactionCarModel.imageUrl,
                                  width: 90.w,
                                  height: 70.h,
                                  fit: BoxFit.cover,
                                ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// اسم السيارة + الموديل
                            Text(
                              "${widget.transactionCarModel.carName}${widget.transactionCarModel.carModel.isNotEmpty ? ' - ${widget.transactionCarModel.carModel}' : ''}",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),

                            /// اسم المستأجر
                            Text(
                              "${local.renter}: ${widget.transactionCarModel.renterName}",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.black87),
                            ),

                            SizedBox(height: 4.h),

                            /// الحالة
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 12.sp,
                                  color: getStatusColor(
                                    widget.transactionCarModel.status,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  translatedStatus,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: getStatusColor(
                                      widget.transactionCarModel.status,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// التواريخ والسعر
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${local.from}: ${widget.transactionCarModel.startDate.split('T')[0]}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.blueGrey),
                          ),
                          Text(
                            '${local.to}: ${widget.transactionCarModel.endDate.split('T')[0]}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.blueGrey),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${widget.transactionCarModel.total}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppTheme.primary,
                                size: 24.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Invoice Section (Expandable)
                  if (_isExpanded)
                    BookingInvoiceSection(
                      basePrice: widget.transactionCarModel.basePrice,
                      commissionAmount:
                          widget.transactionCarModel.commissionAmount,
                      pickupDelivery: widget.transactionCarModel.pickupDelivery,
                      pickupDeliveryPrice:
                          widget.transactionCarModel.pickupDeliveryPrice,
                      total: widget.transactionCarModel.total,
                    ),

                  /// Confirm / Reject Buttons لو الحالة pending
                  if (widget.transactionCarModel.status.toLowerCase() ==
                      'pending') ...[
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: MyCustomButton(
                            text: local.confirm,
                            color: Colors.green,
                            voidCallback: () async {
                              final actionCubit =
                                  context.read<BookingActionCubit>();
                              final bookingCubit = context.read<BookingCubit>();

                              await actionCubit.confirmBooking(
                                widget.transactionCarModel.id,
                              );

                              if (actionCubit.state is BookingActionSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(local.bookingConfirmed),
                                  ),
                                );
                                bookingCubit.fetchBookings();
                              } else if (actionCubit.state
                                  is BookingActionFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(local.bookingFailed)),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: MyCustomButton(
                            text: local.reject,
                            color: Colors.red,
                            voidCallback: () async {
                              final actionCubit =
                                  context.read<BookingActionCubit>();
                              final bookingCubit = context.read<BookingCubit>();

                              await actionCubit.rejectBooking(
                                widget.transactionCarModel.id,
                              );

                              if (actionCubit.state is BookingActionSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(local.bookingRejected),
                                  ),
                                );
                                bookingCubit.fetchBookings();
                              } else if (actionCubit.state
                                  is BookingActionFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(local.bookingFailed)),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],

                  if (state is BookingActionLoading)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
