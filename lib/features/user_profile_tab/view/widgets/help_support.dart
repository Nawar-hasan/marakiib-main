import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_profile_tab/data/support_repo.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/support_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/support_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/themeing/app_theme.dart';
import '../../../../core/widgets/custom_textFild.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:dio/dio.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => SupportCubit(SupportRepository(Dio())),
      child: BlocConsumer<SupportCubit, SupportState>(
        listener: (context, state) {
          if (state is SupportSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: state.support.message,
              ),
            );
            // مسح الحقول بعد الارسال
            nameController.clear();
            emailController.clear();
            subjectController.clear();
            messageController.clear();
          } else if (state is SupportError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(translate.helpSupport),
              centerTitle: true,
              backgroundColor: AppTheme.white,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    taskController: nameController,
                    labelText: translate.nameLabel,
                    hint: translate.pleaseEnterName,
                    showLabelText: true,
                    showPrefixIcon: false,
                    showFillColor: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    validate: (value) => value == null || value.isEmpty
                        ? translate.pleaseEnterName
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    taskController: emailController,
                    labelText: translate.email,
                    hint: translate.enterYourEmail,
                    showLabelText: true,
                    showPrefixIcon: false,
                    showFillColor: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    validate: (value) => value == null || !value.contains('@')
                        ? translate.invalidEmail
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    taskController: subjectController,
                    labelText: translate.subjectHint,
                    hint: translate.writeASubject,
                    showLabelText: true,
                    showPrefixIcon: false,
                    showFillColor: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    validate: (value) => value == null || value.isEmpty
                        ? translate.subjectValidation
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    taskController: messageController,
                    labelText: translate.messageLabel,
                    hint: translate.messageHint,
                    showLabelText: true,
                    showPrefixIcon: false,
                    showFillColor: false,
                    maxLines: 5,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    validate: (value) => value == null || value.isEmpty
                        ? translate.messageValidation
                        : null,
                  ),
                  SizedBox(height: 40.h),
                  state is SupportLoading
                      ? const LoadingIndicator()
                      : MyCustomButton(
                    text: translate.submitButton,
                    voidCallback: () {
                      context.read<SupportCubit>().sendMessage(
                        name: nameController.text,
                        email: emailController.text,
                        subject: subjectController.text,
                        message: messageController.text,
                      );
                    },
                    height: 48.h,
                    width: 267.w,
                    radius: 10.r,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
