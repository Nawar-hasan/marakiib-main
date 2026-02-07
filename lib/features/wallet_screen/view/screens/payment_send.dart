import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/custom_textFild.dart';
import 'package:marakiib_app/features/wallet_screen/view/screens/wep_view.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/payment_send_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/payment_send_state.dart';
import '../../../../core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart'; // لو انت مولد اللوكاليزيشن

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final amountController = TextEditingController();
  // final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text(locale.createPaymentSession,style: Theme.of(context).textTheme.titleLarge), // "Create Payment Session"
        backgroundColor: AppTheme.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              final url = state.data["payment_url"];

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(locale.paymentSessionCreated), // "✔ Payment session created successfully"
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PaymentWebView(url: url)),
              );
            }

            if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${locale.error} ${state.message}"), // "❌ Error ..."
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Amount
                CustomTextField(
                  icon: Icons.account_balance_wallet,
                  taskController: amountController,
                  hint: locale.amount, // "Amount"
                  labelText: locale.amount, // "Amount"
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),

                /// Description
                // CustomTextField(
                //   taskController: descriptionController,
                //   hint: locale.description, // "Description"
                //   labelText: locale.description,
                // ),
                SizedBox(height: 24.h),

                /// Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: state is PaymentLoading
                        ? null
                        : () {
                      final amount = double.tryParse(
                        amountController.text,
                      );

                      if (amount == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(locale.enterValidAmount), // "❌ Enter a valid amount"
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      context.read<PaymentCubit>().createPaymentSession(
                        amount: amount,
                        currency: "JOD",
                        description: "JOD",
                      );
                    },
                    child: state is PaymentLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      locale.createPayment, // "Create Payment"
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
