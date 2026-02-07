import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/add_review_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/add_review_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WriteReviewBottomSheet extends StatefulWidget {
  final int carId;
  const WriteReviewBottomSheet({super.key, required this.carId});

  @override
  State<WriteReviewBottomSheet> createState() => _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState extends State<WriteReviewBottomSheet> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _showSuccessSnack(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  }

  void _showErrorSnack(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocConsumer<AddReviewCubit, AddReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          _showSuccessSnack('تم اضافه التعليق بنجاح');
          context.pop(true); // عشان نعمل refresh في الصفحة الرئيسية
        } else if (state is AddReviewFailure) {
          _showErrorSnack(state.error);
        }
      },
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  Text(
                    translate.whatIsYourRate,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return GestureDetector(
                        onTap: () => setState(() => _rating = starIndex),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Icon(
                            _rating >= starIndex
                                ? Icons.star
                                : Icons.star_border,
                            color: AppTheme.primary,
                            size: 32.sp,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    translate.pleaseAddRatingAndReview,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: translate.yourReview,
                      filled: true,
                      fillColor: AppTheme.tertiary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  MyCustomButton(
                    text: state is AddReviewLoading
                        ? translate.sending
                        : translate.sendReview,
                    width: double.infinity,
                    height: 50.h,
                    radius: 6.r,
                    fontSize: 18.sp,
                    voidCallback: state is AddReviewLoading
                        ? () {}
                        : () {
                      final comment = _reviewController.text.trim();
                      if (_rating == 0 || comment.isEmpty) {
                        _showErrorSnack(
                            translate.pleaseAddRatingAndReview);
                        return;
                      }
                      context.read<AddReviewCubit>().submitReview(
                        carId: widget.carId,
                        rating: _rating,
                        comment: comment,
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  if (state is AddReviewLoading) const LoadingIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
