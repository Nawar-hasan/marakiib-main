import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/resend_otp_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_button.dart';

class ResetOtpScreen extends StatefulWidget {
  final Map<String, String> data; // استقبل Map بدل String

  const ResetOtpScreen({super.key, required this.data});

  @override
  State<ResetOtpScreen> createState() => _ResetOtpScreenState();
}

class _ResetOtpScreenState extends State<ResetOtpScreen> {
  String currentOtp = "";

  @override
  Widget build(BuildContext context) {
    final email = widget.data['email'] ?? '';
    final otpMethod = widget.data['otp_method'] ?? 'sms';


    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.checkEmailTitle,
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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.otpMessage(email),
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            // OTP Field
            Directionality(
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

            SizedBox(height: 30.h),

            // Resend OTP
            ResendOtpText(email: email, otpMethod: otpMethod,),
            SizedBox(height: 30.h),

            // Verify Button
            MyCustomButton(
              text: AppLocalizations.of(context)!.verifyCodeBtn,
              width: double.infinity,
              height: 52.h,
              radius: 12.r,
              fontSize: 16.sp,
              color: AppTheme.black,
              textColor: Colors.white,
              borderColor: AppTheme.black,
              voidCallback: () {
                if (currentOtp.length == 6) {
                  // إرسال email و OTP كـ Map
                  context.push(
                    '/ResetPasswordScreen',
                    extra: {'email': email, 'otp': currentOtp},
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text(AppLocalizations.of(context)!.otpInvalid),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
