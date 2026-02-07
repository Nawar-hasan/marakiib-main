import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/auth/forget_password/data/rest_password.dart';
import 'package:marakiib_app/features/auth/forget_password/view_model/rest_password_cubit.dart';
import 'package:marakiib_app/features/auth/forget_password/view_model/rest_password_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../../core/network/end_point.dart';
import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otpCode;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otpCode,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ResetPasswordCubit(
            ResetPasswordService(Dio(BaseOptions(baseUrl: EndPoints.baseUrl))),
          ),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(message: state.message),
            );
            context.go('/LoginScreen');
          } else if (state is ResetPasswordFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.error),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.setNewPasswordTitle,
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
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.setNewPasswordMessage,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16.sp,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),

                    CustomTextField(
                      taskController: passwordController,
                      hint: AppLocalizations.of(context)!.newPasswordHint,
                      icon: Icons.lock,
                      ispassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.newPasswordRequired;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context)!.passwordTooShort;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      taskController: confirmPasswordController,
                      hint: AppLocalizations.of(context)!.confirmPasswordHint,
                      icon: Icons.lock_outline,
                      ispassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.confirmPasswordRequired;
                        }
                        if (value != passwordController.text) {
                          return AppLocalizations.of(
                            context,
                          )!.passwordsNotMatch;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),

                    state is ResetPasswordLoading
                        ? const LoadingIndicator()
                        : MyCustomButton(
                          text: AppLocalizations.of(context)!.updatePasswordBtn,
                          width: double.infinity,
                          height: 52.h,
                          radius: 12.r,
                          fontSize: 16.sp,
                          color: AppTheme.black,
                          textColor: Colors.white,
                          borderColor: AppTheme.black,
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ResetPasswordCubit>().resetPassword(
                                email: widget.email,
                                otpCode: widget.otpCode,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
                            }
                          },
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
