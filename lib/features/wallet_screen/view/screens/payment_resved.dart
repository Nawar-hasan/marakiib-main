import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_textFild.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/wallet_screen/data/methods.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/methods_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/methods_state.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/withdraw_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/withdraw_state.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  WithdrawalMethod? selectedMethod;
  final Map<String, TextEditingController> controllers = {};
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WithdrawalMethodsCubit(Dio())..getWithdrawalMethods(),
        ),
        BlocProvider(create: (_) => WithdrawCubit(Dio())),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(local.withdrawalPageTitle)),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<WithdrawalMethodsCubit, WithdrawalMethodsState>(
                builder: (context, state) {
                  if (state is WithdrawalMethodsLoading) {
                    return const Center(child: LoadingIndicator());
                  }
                  if (state is WithdrawalMethodsFailure) {
                    return Center(child: Text("Error: ${state.error}"));
                  }
                  if (state is WithdrawalMethodsSuccess) {
                    final methods = state.methods;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.chooseMethod,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // المبلغ
                        CustomTextField(
                          taskController: amountController,
                          labelText: local.amount,
                          hint: local.enterAmount,
                          keyboardType: TextInputType.number,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return local.requiredField;
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),

                        // Dropdown اختيار طريقة السحب
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppTheme.gray50,
                              width: 1.5,
                            ),
                          ),
                          child: DropdownButton<WithdrawalMethod>(
                            value: selectedMethod,
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: Text(local.chooseMethod),
                            items:
                                methods.map((method) {
                                  return DropdownMenuItem(
                                    value: method,
                                    child: Text(method.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMethod = value;
                                controllers.clear();
                                for (var f in value!.fields) {
                                  controllers[f.key] = TextEditingController();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 20.h),

              if (selectedMethod != null)
                Expanded(
                  child: ListView(
                    children:
                        selectedMethod!.fields.map((field) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: CustomTextField(
                              taskController: controllers[field.key]!,
                              labelText: field.label,
                              hint: field.label,
                              keyboardType:
                                  field.type == "number"
                                      ? TextInputType.number
                                      : TextInputType.text,
                              validate: (value) {
                                if (field.required &&
                                    (value == null || value.isEmpty)) {
                                  return local.requiredField;
                                }
                                return null;
                              },
                            ),
                          );
                        }).toList(),
                  ),
                ),

              if (selectedMethod != null)
                BlocConsumer<WithdrawCubit, WithdrawState>(
                  listener: (context, state) {
                    if (state is WithdrawSuccess) {
                      showTopSnackBar(
                        Overlay.of(context)!,
                        CustomSnackBar.success(
                          message:
                              state.message.isNotEmpty
                                  ? state.message
                                  : local.withdrawSuccess,
                        ),
                      );
                      context.push('/WalletScreen');
                    } else if (state is WithdrawFailure) {
                      showTopSnackBar(
                        Overlay.of(context)!,
                        CustomSnackBar.error(
                          message:
                              state.error.isNotEmpty
                                  ? state.error
                                  : local.withdrawFailure,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is WithdrawLoading
                                ? null
                                : () {
                                  final details = <String, dynamic>{};
                                  controllers.forEach((key, controller) {
                                    details[key] = controller.text;
                                  });
                                  final amount =
                                      double.tryParse(amountController.text) ??
                                      0;
                                  context.read<WithdrawCubit>().withdraw(
                                    methodId: selectedMethod!.id,
                                    amount: amount,
                                    details: details,
                                  );
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child:
                            state is WithdrawLoading
                                ? const LoadingIndicator()
                                : Text(
                                  local.continueButton,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
