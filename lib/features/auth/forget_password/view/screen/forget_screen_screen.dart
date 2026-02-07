import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/auth/forget_password/data/forget_password_service.dart';
import 'package:marakiib_app/features/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:marakiib_app/features/auth/forget_password/view_model/forget_password_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../../core/network/end_point.dart';
import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  String otpMethod = "sms";

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider(
      create:
          (_) => ForgetPasswordCubit(
            ForgetPasswordService(Dio(BaseOptions(baseUrl: EndPoints.baseUrl))),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            translate.forgetPasswordTitle,
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
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(message: state.message),
              );

              // تمرير البيانات بشكل آمن مع null check
              context.go(
                '/otp-verification',
                extra: {
                  "email": emailController.text.trim(),
                  "otp_method": otpMethod.isNotEmpty ? otpMethod : "sms",
                },
              );
            } else if (state is ForgetPasswordFailure) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(message: state.error),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      translate.forgetPasswordMessage,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16.sp,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),

                    // حقل البريد الإلكتروني
                    CustomTextField(
                      taskController: emailController,
                      hint: translate.emailHint1,
                      icon: Icons.email,
                    ),
                    SizedBox(height: 20.h),

                    /// اختيار طريقة OTP
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('SMS'),
                            value: "sms",
                            groupValue: otpMethod,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  otpMethod = value;
                                });
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Email'),
                            value: "email",
                            groupValue: otpMethod,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  otpMethod = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // زر إعادة تعيين كلمة المرور
                    state is ForgetPasswordLoading
                        ? const LoadingIndicator()
                        : MyCustomButton(
                          text: translate.resetPasswordBtn,
                          width: double.infinity,
                          height: 52.h,
                          radius: 12.r,
                          fontSize: 16.sp,
                          color: AppTheme.black,
                          textColor: Colors.white,
                          borderColor: AppTheme.black,
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              // إرسال البيانات مع الـ Cubit
                              context
                                  .read<ForgetPasswordCubit>()
                                  .forgetPassword(
                                    emailController.text.trim(),
                                    otpMethod.isNotEmpty ? otpMethod : "sms",
                                  );
                            }
                          },
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
