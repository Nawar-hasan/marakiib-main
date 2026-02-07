import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/widgets/otp_dailog.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/social%20_auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_date.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/phone_number_field.dart';
import '../../view_model/rental_office_register_cubit.dart';
import '../../view_model/rental_office_register_state.dart';
import '../data/data_source/rental_office_register_repository.dart';
import '../data/model/rental_office_register_model.dart';

class SignUpVendorRentalOffice extends StatefulWidget {
  const SignUpVendorRentalOffice({super.key});

  @override
  State<SignUpVendorRentalOffice> createState() =>
      _SignUpVendorRentalOfficeState();
}

class _SignUpVendorRentalOfficeState extends State<SignUpVendorRentalOffice> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController commercialRegController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController licenseExpiryController = TextEditingController();

  File? licenseImage;
  OtpMethod? selectedOtp;


  Future<void> pickLicenseImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        licenseImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocProvider(
      create:
          (context) =>
              RentalOfficeRegisterCubit(RentalOfficeRegisterRepository(Dio())),
      child: BlocConsumer<RentalOfficeRegisterCubit, RentalOfficeRegisterState>(
        listener: (context, state) {
          if (state is RentalOfficeRegisterSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(message: state.message),
            );


            context.go(
              '/otp',
              extra: {
                'email': emailController.text.trim(),
                'otp_method': selectedOtp?.name,
              },
            );            } else if (state is RentalOfficeRegisterFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.error),
            );

          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    taskController: nameController,
                    hint: l10n.nameHint,
                    icon: Icons.person,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.nameError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  CustomTextField(
                    taskController: emailController,
                    hint: l10n.emailHint,
                    icon: Icons.email,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.emailErrorEmpty;
                      }
                      if (!value.contains('@')) {
                        return l10n.emailErrorInvalid;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  CustomPhoneField(
                    controller: phoneController,
                    label: l10n.phoneHint,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.phoneError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  Align(
                    alignment:
                        isArabic ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(
                      l10n.licensePhoto,
                      style: TextStyle(fontSize: 14, color: AppTheme.black),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              licenseImage == null
                                  ? l10n.uploadDrivingLicense
                                  : l10n.imageSelected,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MyCustomButton(
                          text: l10n.uploadNow,
                          width: double.infinity,
                          height: 48.h,
                          radius: 10.r,
                          fontSize: 12.sp,
                          color: AppTheme.primary,
                          textColor: AppTheme.white,
                          borderColor: AppTheme.primary,
                          voidCallback: pickLicenseImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  CustomDatePickerField(
                    controller: licenseExpiryController,
                    labelText: l10n.carLicenseExpiryDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.selectExpiryDate;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  CustomTextField(
                    taskController: commercialRegController,
                    hint: l10n.commercialRegHint,
                    icon: Icons.file_copy,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.commercialRegError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

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
                  SizedBox(height: 20.h),

                  CustomTextField(
                    taskController: confirmPasswordController,
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
                  SizedBox(height: 30.h),

                  MyCustomButton(
                    text: state is RentalOfficeRegisterLoading
                        ? l10n.loading
                        : l10n.signUpBtn,
                    width: double.infinity,
                    height: 52.h,
                    radius: 12.r,
                    fontSize: 16.sp,
                    color: AppTheme.black,
                    textColor: AppTheme.white,
                    borderColor: AppTheme.black,
                    voidCallback: () async {
                      if (_formKey.currentState!.validate()) {
                        if (licenseImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.drivingLicenseError)),
                          );
                          return;
                        }

                        // ======= نفتح الـ OTP Dialog =======
                        selectedOtp = await OtpMethodDialog.show(context);
                        if (selectedOtp == null) return; // لو المستخدم ضغط إلغاء

                        // ======= نعمل الـ Model مع otpMethod =======
                        final user = RentalOfficeRegisterModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                          phoneNumber: phoneController.text,
                          address: "",
                          latitude: 0.0,
                          longitude: 0.0,
                          carLicenseImage: licenseImage!.path,
                          carLicenseExpiryDate: licenseExpiryController.text,
                          commercialRegistrationNumber: commercialRegController.text,
                          otpMethod: selectedOtp!.name, // هنا القيمة المختارة
                        );

                        // ======= نرسل البيانات للـ Cubit =======
                        context.read<RentalOfficeRegisterCubit>().register(user);
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.gray100, thickness: 1)),
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
                      Expanded(child: Divider(color: AppTheme.gray100, thickness: 1)),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        iconData: FontAwesomeIcons.facebookF,
                        iconColor: Color(0xff1877F2),
                        provider: 'facebook',
                        role: 'rental_office',
                      ),
                      // SizedBox(width: 15.w),
                      // SocialLoginButton(
                      //   iconData: FontAwesomeIcons.google,
                      //   iconColor: Colors.red,
                      //   provider: 'google',
                      //   role: 'rental_office',
                      // ),
                    ],
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

Widget _buildSocialIcon(IconData iconData, Color iconColor) {
  return Container(
    width: 44.w,
    height: 44.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade400, width: 1),
    ),
    child: Center(child: FaIcon(iconData, color: iconColor, size: 24.sp)),
  );
}
