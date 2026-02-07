import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/resend_otp_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../sign_up/view/data/model/verify_otp_model.dart';
import '../../../sign_up/view_model/verify_otp_cubit.dart';
import '../../../sign_up/view_model/verify_otp_state.dart';

class Otp extends StatefulWidget {
  final String email;
  final String? otpMethod;

  const Otp({super.key, required this.email,required this.otpMethod});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String currentOtp = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.otpTitle,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppTheme.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppTheme.primary),
        centerTitle: true,
      ),
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: state.message,
              ),
            );
            context.go('/LoginScreen');
          } else if (state is VerifyOtpFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  l10n.otpDescription,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),

                Form(
                  key: _formKey,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 50.h,
                        fieldWidth: 40.w,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        activeColor: AppTheme.primary,
                        selectedColor: AppTheme.primary,
                        inactiveColor: Colors.grey.shade400,
                        borderWidth: 2,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onChanged: (value) {
                        setState(() {
                          currentOtp = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                ResendOtpText(email: widget.email, otpMethod: widget.otpMethod!,),
                SizedBox(height: 30.h),

                state is VerifyOtpLoading
                    ? const LoadingIndicator()
                    : MyCustomButton(
                  text: l10n.verifyOtpBtn,
                  width: double.infinity,
                  height: 52.h,
                  radius: 12.r,
                  fontSize: 16.sp,
                  color: AppTheme.black,
                  textColor: Colors.white,
                  borderColor: AppTheme.black,
                  voidCallback: () {
                    if (currentOtp.length == 6) {
                      final verifyData = VerifyOtpModel(
                        email: widget.email,
                        otp_code: currentOtp,
                      );
                      context.read<VerifyOtpCubit>().verifyOtp(verifyData);
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.info(
                          message: "Enter full 6 digit OTP",
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
