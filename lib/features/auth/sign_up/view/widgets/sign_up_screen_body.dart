import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/core/widgets/otp_dailog.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/social%20_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/phone_number_field.dart';
import '../../view_model/user_register_cubit.dart';
import '../../view_model/user_register_state.dart';
import '../data/model/register_model.dart';

class SignUpScreenBody extends StatefulWidget {
  const SignUpScreenBody({super.key});

  @override
  State<SignUpScreenBody> createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();

  File? drivingLicenseImage;
  OtpMethod? selectedOtp; // ← هنا المخزن للاختيار

  Future<void> pickDrivingLicenseImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        drivingLicenseImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<UserRegisterCubit, UserRegisterState>(
      listener: (context, state) {
        if (state is UserRegisterSuccess) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: state.message),
          );

          // هنا نبعت البريد و otpMethod للـ OTP screen
          context.go(
            '/otp',
            extra: {
              'email': emailController.text.trim(),
              'otp_method': selectedOtp?.name,
            },
          );
        } else if (state is UserRegisterFailure) {
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
                  l10n.signUp,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: AppTheme.primary),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    l10n.signUpDescription,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppTheme.gray),
                  ),
                ),
                SizedBox(height: 30.h),

                CustomTextField(
                  taskController: nameController,
                  hint: l10n.nameHint,
                  icon: Icons.person,
                  validate:
                      (value) =>
                          value == null || value.isEmpty
                              ? l10n.nameError
                              : null,
                ),
                SizedBox(height: 10.h),

                CustomTextField(
                  taskController: emailController,
                  hint: l10n.emailHint,
                  icon: Icons.email,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailErrorEmpty;
                    }
                    if (!value.contains('@')) return l10n.emailErrorInvalid;
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                CustomPhoneField(
                  controller: phoneController,
                  label: l10n.phoneHint,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? l10n.phoneError
                              : null,
                ),
                SizedBox(height: 10.h),

                CustomTextField(
                  taskController: addressController,
                  hint: l10n.addressHint,
                  icon: Icons.home,
                  validate:
                      (value) =>
                          value == null || value.isEmpty
                              ? l10n.addressError
                              : null,
                ),

                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: pickDrivingLicenseImage,
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        drivingLicenseImage == null
                            ? Center(child: Text(l10n.drivingLicensePrompt))
                            : Image.file(
                              drivingLicenseImage!,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                SizedBox(height: 10.h),


                CustomTextField(
                  taskController: passwordController,
                  hint: l10n.passwordHint,
                  icon: Icons.lock,
                  ispassword: true,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.passwordErrorEmpty;
                    }
                    if (value.length < 6) {
                      return l10n.passwordErrorShort;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),


                CustomTextField(
                  taskController: passwordConfirmationController,
                  hint: l10n.confirmPasswordHint,
                  icon: Icons.lock,
                  ispassword: true,
                  validate: (value) {
                    if (value != passwordController.text) {
                      return l10n.confirmPasswordError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppTheme.gray100, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        l10n.orSignInWith,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: AppTheme.gray901,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: AppTheme.gray100, thickness: 1),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      iconData: FontAwesomeIcons.facebookF,
                      iconColor: Color(0xff1877F2),
                      provider: 'facebook',
                      role: 'customer',
                    ),
                    // SizedBox(width: 15.w),
                    // SocialLoginButton(
                    //   iconData: FontAwesomeIcons.google,
                    //   iconColor: Colors.red,
                    //   provider: 'google',
                    //   role: 'private_renter',
                    // ),
                  ],
                ),

                SizedBox(height: 30.h),

                state is UserRegisterLoading
                    ? const LoadingIndicator()
                    : MyCustomButton(
                      text: l10n.signUpBtn,
                      width: double.infinity,
                      height: 52.h,
                      radius: 12.r,
                      fontSize: 16.sp,
                      color: AppTheme.black,
                      textColor: AppTheme.white,
                      borderColor: AppTheme.black,
                      voidCallback: () async {
                        if (_formKey.currentState!.validate()) {
                          if (drivingLicenseImage == null) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: l10n.drivingLicenseError,
                              ),
                            );
                            return;
                          }

                          // ======= فتح الـ OTP Dialog =======
                          selectedOtp = await OtpMethodDialog.show(context);
                          if (selectedOtp == null) return;

                          // ======= جلب بيانات الموقع من SharedPreferences =======
                          final prefs = await SharedPreferences.getInstance();
                          double latitude = prefs.getDouble("user_lat") ?? 0;
                          double longitude = prefs.getDouble("user_lng") ?? 0;

                          // ======= إنشاء UserRegisterModel مع otpMethod =======
                          final user = UserRegisterModel(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            passwordConfirmation:
                                passwordConfirmationController.text,
                            phoneNumber: phoneController.text,
                            address: addressController.text,
                            latitude: latitude,
                            longitude: longitude,
                            drivingLicenseImage: drivingLicenseImage!.path,
                            otpMethod: selectedOtp!.name,
                          );

                          // ======= إرسال البيانات للـ Cubit =======
                          context.read<UserRegisterCubit>().register(user);
                        }
                      },
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
