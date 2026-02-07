import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/booking_screen/view_model/add_book_cubit.dart';
import 'package:marakiib_app/features/booking_screen/view_model/add_book_state.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textFild.dart';
import '../../view_model/booking_details_view_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int carId;
  final String rentalPrice;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;
  final String? plateType;

  const BookingDetailsScreen({
    super.key,
    required this.carId,
    required this.rentalPrice,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
    this.plateType,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late BookingDetailsViewModel viewModel;
  final TextEditingController daysController = TextEditingController();
  bool _isPickupDeliverySelected = false;

  @override
  void initState() {
    super.initState();
    viewModel = BookingDetailsViewModel();
  }

  Future<void> _pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        viewModel.startDate = picked;
        _updateEndDate();
      });
    }
  }

  void _updateEndDate() {
    if (viewModel.startDate != null && daysController.text.isNotEmpty) {
      final int days = int.tryParse(daysController.text) ?? 0;
      setState(() {
        viewModel.endDate = viewModel.startDate!.add(Duration(days: days));
      });
    }
  }

  double _calculateSubtotal() {
    final days = int.tryParse(daysController.text) ?? 0;
    final price = double.tryParse(widget.rentalPrice) ?? 0;
    return price * days;
  }

  double _calculatePickupDeliveryPrice() {
    if (!_isPickupDeliverySelected || widget.pickupDelivery != 1) {
      return 0;
    }
    return double.tryParse(widget.pickupDeliveryPrice ?? '0') ?? 0;
  }

  double _calculateCommission(double currentPrice) {
    if (widget.commissionValue == null || widget.commissionType == null) {
      return 0;
    }

    final commissionVal = double.tryParse(widget.commissionValue!) ?? 0;
    final int days = int.tryParse(daysController.text) ?? 1;
    final bool isGreenPlate =
        widget.plateType == 'green' || widget.plateType == 'خضراء';

    double commission = 0;
    if (widget.commissionType == 'fixed') {
      commission = commissionVal;
    } else if (widget.commissionType == 'percentage') {
      // For percentage, we calculate based on the currentPrice (which is Subtotal + Pickup)
      commission = currentPrice * (commissionVal / 100);
    }

    if (isGreenPlate) {
      return commission * days;
    }

    return commission;
  }

  double _calculateTotal() {
    double subtotal = _calculateSubtotal();
    double pickupDelivery = _calculatePickupDeliveryPrice();
    double priceBeforeCommission = subtotal + pickupDelivery;
    double commission = _calculateCommission(priceBeforeCommission);
    return priceBeforeCommission + commission;
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => AddBookCubit(Dio()),
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: translate.bookingDetails),
          body: BlocConsumer<AddBookCubit, AddBookState>(
            listener: (context, state) {
              if (state is AddBookSuccess) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message: translate.bookingAddedSuccess,
                  ),
                );
                Navigator.pop(context);
              } else if (state is AddBookError) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: state.message),
                );
              }
            },
            builder: (context, state) {
              var cubit = context.read<AddBookCubit>();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    /// رقم الهاتف
                    CustomTextField(
                      icon: Icons.phone,
                      taskController: viewModel.phoneController,
                      hint: translate.phoneNumber,
                      keyboardType: TextInputType.phone,
                      fillColor: Colors.white,
                      borderColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),

                    /// اختيار تاريخ البداية
                    GestureDetector(
                      onTap: _pickStartDate,
                      child: AbsorbPointer(
                        child: CustomTextField(
                          taskController: TextEditingController(
                            text:
                                viewModel.startDate == null
                                    ? ""
                                    : viewModel.getFormattedStartDate(),
                          ),
                          hint: translate.selectStartDate,
                          fillColor: Colors.white,
                          borderColor: Colors.grey.shade300,
                          showPrefixIcon: true,
                          icon: Icons.calendar_today,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// عدد الأيام
                    CustomTextField(
                      icon: Icons.calendar_month_rounded,
                      taskController: daysController,
                      hint: translate.numberOfDays,
                      keyboardType: TextInputType.number,
                      fillColor: Colors.white,
                      borderColor: Colors.grey.shade300,
                      onChanged: (_) {
                        _updateEndDate();
                        setState(() {}); // Refresh to update price
                      },
                    ),
                    const SizedBox(height: 16),

                    /// عرض تاريخ الانتهاء (المحسوب)
                    if (viewModel.endDate != null)
                      Text(
                        "${translate.endDate}${viewModel.getFormattedEndDate()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 24),

                    /// Pickup & Delivery Checkbox
                    if (widget.pickupDelivery == 1)
                      CheckboxListTile(
                        title: Text(
                          widget.pickupDeliveryPrice != null
                              ? "${translate.pickupAndDelivery} (+${widget.pickupDeliveryPrice} ${translate.currency})"
                              : translate.pickupAndDelivery,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        value: _isPickupDeliverySelected,
                        onChanged: (value) {
                          setState(() {
                            _isPickupDeliverySelected = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                    const SizedBox(height: 24),

                    /// Price Breakdown
                    if (daysController.text.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate.invoiceDetails,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            /// Subtotal
                            _buildPriceRow(
                              "${translate.subtotal} (${widget.rentalPrice} × ${daysController.text} ${translate.day})",
                              "${_calculateSubtotal().toStringAsFixed(2)} ${translate.currency}",
                              false,
                            ),

                            /// Pickup & Delivery
                            if (_isPickupDeliverySelected &&
                                widget.pickupDelivery == 1) ...[
                              SizedBox(height: 8.h),
                              _buildPriceRow(
                                translate.pickupAndDelivery,
                                "+${_calculatePickupDeliveryPrice().toStringAsFixed(2)} ${translate.currency}",
                                false,
                              ),
                            ],

                            /// Commission
                            if (widget.commissionValue != null &&
                                widget.commissionType != null) ...[
                              SizedBox(height: 8.h),
                              _buildPriceRow(
                                "${translate.commission} (${widget.commissionType == 'fixed' ? translate.fixed : '${widget.commissionValue}%'})",
                                "+${_calculateCommission(_calculateSubtotal() + _calculatePickupDeliveryPrice()).toStringAsFixed(2)} ${translate.currency}",
                                false,
                              ),
                            ],

                            Divider(height: 24.h, thickness: 2),

                            /// Total
                            _buildPriceRow(
                              translate.total,
                              "${_calculateTotal().toStringAsFixed(2)} ${translate.currency}",
                              true,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 32),

                    /// زر التأكيد
                    state is AddBookLoading
                        ? const Center(child: LoadingIndicator())
                        : Center(
                          child: MyCustomButton(
                            text: translate.confirmBooking,
                            voidCallback: () {
                              if (viewModel.startDate == null ||
                                  viewModel.endDate == null) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.info(
                                    message: translate.pleaseSelectBookingDates,
                                  ),
                                );
                                return;
                              }

                              cubit.addBooking(
                                carId: widget.carId,
                                startDate:
                                    viewModel.getFormattedStartDate() ?? "",
                                endDate: viewModel.getFormattedEndDate() ?? "",
                                contactNumber: viewModel.phoneController.text,
                                extraOptions: ["option1", "option2"],
                                pickupDelivery:
                                    _isPickupDeliverySelected ? 1 : 0,
                              );
                            },
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.green[700] : Colors.black87,
          ),
        ),
      ],
    );
  }
}
