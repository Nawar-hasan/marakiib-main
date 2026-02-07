import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/features/auth/sign_up/view_model/resend_otp_state.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../view_model/resend_otp_cubit.dart';

class ResendOtpText extends StatelessWidget {
  final String email;
  final String otpMethod;


  const ResendOtpText({super.key, required this.email, required this.otpMethod});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResendOtpCubit(),
      child: BlocConsumer<ResendOtpCubit, ResendOtpState>(
        listener: (context, state) {
          if (state is ResendOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ResendOtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return RichText(
            text: TextSpan(
              text: "${AppLocalizations.of(context)!.otpResendPrompt} ",
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 14.sp,
                color: Colors.grey[800],
              ),
              children: [
                TextSpan(
                  text: state is ResendOtpLoading
                      ? AppLocalizations.of(context)!.loading
                      : AppLocalizations.of(context)!.otpResendAction,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 14.sp,
                    color: AppTheme.primary,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (state is! ResendOtpLoading) {
                        context.read<ResendOtpCubit>().resendOtp(
                          email,
                          otpMethod, // ← هنا الإضافة المهمة
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
