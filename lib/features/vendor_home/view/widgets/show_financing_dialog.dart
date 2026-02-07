import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_home/data/financing_model.dart';
import 'package:marakiib_app/features/vendor_home/data/financing_repo.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_plans_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_plans_state.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_state.dart';

void showFinancingDialog({
  required BuildContext context,
  required VendorCarModel car,
}) {
  final daysController = TextEditingController();

  final financingPlansCubit = context.read<FinancingPlansCubit>();
  final financingCubit = context.read<FinancingCubit>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FinancingCubit(FinancingRepository())),
          BlocProvider(
            create: (_) => FinancingPlansCubit()..getFinancingPlans(),
          ),
        ],
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // العنوان
                Text(
                  AppLocalizations.of(context)!.send_financing_request,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.h),

                // حقل عدد الأيام
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.days_count,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: daysController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // تفاصيل الخطة
                BlocBuilder<FinancingPlansCubit, FinancingPlansState>(
                  builder: (context, planState) {
                    if (planState is FinancingPlansLoading) {
                      return const LoadingIndicator();
                    }
                    if (planState is FinancingPlansFailure) {
                      return Text(
                        planState.error,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      );
                    }
                    if (planState is FinancingPlansSuccess) {
                      final plans = planState.plans;
                      final selectedPlan = plans.firstWhere(
                        (p) =>
                            p.plateType.toLowerCase() ==
                            (car.plateType?.toLowerCase() ?? ''),
                        orElse: () => plans.first,
                      );

                      return Column(
                        children: [
                          // اسم الخطة
                          Text(
                            '${AppLocalizations.of(context)!.planName}: ${selectedPlan.name}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),

                          // الوصف
                          if (selectedPlan.description != null &&
                              selectedPlan.description!.isNotEmpty)
                            Text(
                              selectedPlan.description!,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),

                          SizedBox(height: 16.h),

                          // السعر اليومي
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '${AppLocalizations.of(context)!.dailyPrice}: ${selectedPlan.dailyPrice} JOD',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // المجموع (إذا تم إدخال عدد الأيام)
                          ValueListenableBuilder(
                            valueListenable: daysController,
                            builder: (context, value, child) {
                              final days = int.tryParse(daysController.text);
                              if (days != null && days > 0) {
                                final total =
                                    double.parse(selectedPlan.dailyPrice) *
                                    days;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '${AppLocalizations.of(context)!.total}: ${total.toStringAsFixed(2)} JOD',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: 20.h),

                // الأزرار
                BlocBuilder<FinancingCubit, FinancingState>(
                  builder: (context, financeState) {
                    return financeState is FinancingLoading
                        ? const LoadingIndicator()
                        : Column(
                          children: [
                            // زر الإرسال
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (daysController.text.isEmpty) {
                                    if (dialogContext.mounted) {
                                      ScaffoldMessenger.of(
                                        dialogContext,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'يرجى إدخال عدد الأيام',
                                          ),
                                        ),
                                      );
                                    }
                                    return;
                                  }

                                  final days = int.tryParse(
                                    daysController.text,
                                  );
                                  if (days == null || days <= 0) {
                                    if (dialogContext.mounted) {
                                      ScaffoldMessenger.of(
                                        dialogContext,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('عدد الأيام غير صالح'),
                                        ),
                                      );
                                    }
                                    return;
                                  }

                                  final planState = financingPlansCubit.state;
                                  if (planState is! FinancingPlansSuccess)
                                    return;

                                  final plan = planState.plans.firstWhere(
                                    (p) =>
                                        p.plateType.toLowerCase() ==
                                        (car.plateType?.toLowerCase() ?? ''),
                                    orElse: () => planState.plans.first,
                                  );

                                  final model = FinancingModel(
                                    carId: car.id!,
                                    planId: plan.id,
                                    days: days,
                                  );

                                  if (!dialogContext.mounted) return;
                                  await financingCubit.addFinancing(model);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.send,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            // زر الإلغاء
                            SizedBox(

                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (dialogContext.mounted &&
                                      Navigator.of(dialogContext).canPop()) {
                                    Navigator.pop(dialogContext);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  side: BorderSide(color: Colors.grey[300]!),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
