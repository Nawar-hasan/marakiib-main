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
import 'package:marakiib_app/core/widgets/otp_dailog.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/social%20_auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_date.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/phone_number_field.dart';
import '../../view_model/private_renter_register_cubit.dart';
import '../../view_model/private_renter_register_state.dart';
import '../data/model/private_renter_register_model.dart';
import '../data/data_source/private_renter_register_repository.dart';

class SignUpVendorPrivateRenter extends StatefulWidget {
  const SignUpVendorPrivateRenter({super.key});

  @override
  State<SignUpVendorPrivateRenter> createState() =>
      _SignUpVendorPrivateRenterState();
}

class _SignUpVendorPrivateRenterState extends State<SignUpVendorPrivateRenter> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController licenseExpiryController =
  TextEditingController();
  OtpMethod? selectedOtp;

  File? licenseImage;

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
      create: (context) =>
          PrivateRenterRegisterCubit(PrivateRenterRegisterRepository(Dio())),
      child: BlocConsumer<PrivateRenterRegisterCubit,
          PrivateRenterRegisterState>(
        listener: (context, state) {
          if (state is PrivateRenterRegisterSuccess) {
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
            );          } else if (state is PrivateRenterRegisterFailure) {
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
                    onChanged: (number) {
                      print('Full phone number: $number');
                    },
                  ),
                  SizedBox(height: 20.h),

                  Align(
                    alignment:
                    isArabic ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(
                      l10n.licensePhoto,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.black,
                        fontWeight: FontWeight.w400,
                      ),
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
                                  ? l10n.uploadDrivingLicens
                                  : l10n.imageSelected,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14.sp),
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
                    text: state is PrivateRenterRegisterLoading
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
                            SnackBar(
                              content: Text(l10n.drivingLicenseError),
                            ),
                          );
                          return;
                        }

                        // ======= نفتح الـ OTP Dialog =======
                        selectedOtp = await OtpMethodDialog.show(context);
                        if (selectedOtp == null) return;

                        // ======= نعمل الـ Model مع otpMethod =======
                        final user = PrivateRenterRegisterModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                          phoneNumber: phoneController.text,
                          address: "",
                          latitude: 0.0,
                          longitude: 0.0,
                          role: "private_renter",
                          carLicenseImage: licenseImage!.path,
                          carLicenseExpiryDate: licenseExpiryController.text,
                          otpMethod: selectedOtp!.name, // هنا القيمة المختارة
                        );

                        // ======= نرسل البيانات للـ Cubit =======
                        context.read<PrivateRenterRegisterCubit>().register(user);
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
                        role: 'private_renter',
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

                  // Uncomment and update the RichText section if needed
                  /*
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: l10n.noAccount,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: AppTheme.black,
                          fontSize: 16.sp,
                        ),
                        children: [
                          TextSpan(
                            text: l10n.signUp,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 30.h),
                                          padding: EdgeInsets.only(
                                            left: 20.w,
                                            right: 20.w,
                                            bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom +
                                                20.h,
                                            top: 20.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20.r),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 40.w,
                                                height: 5.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Text(
                                                l10n.chooseAccountType,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 30.h),
                                              MyCustomButton(
                                                text: l10n.userBtn,
                                                width: double.infinity,
                                                height: 52.h,
                                                radius: 12.r,
                                                fontSize: 16.sp,
                                                color: AppTheme.primary,
                                                textColor: Colors.white,
                                                borderColor: AppTheme.primary,
                                                voidCallback: () {
                                                  Navigator.pop(context);
                                                  context.push('/UserRegister');
                                                },
                                              ),
                                              SizedBox(height: 12.h),
                                              MyCustomButton(
                                                text: l10n.vendorBtn,
                                                width: double.infinity,
                                                height: 52.h,
                                                radius: 12.r,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                                textColor: AppTheme.primary,
                                                borderColor: AppTheme.primary,
                                                voidCallback: () {
                                                  Navigator.pop(context);
                                                  context.push('/VendorRegister');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -20,
                                          right: 20,
                                          child: GestureDetector(
                                            onTap: () => Navigator.of(context).pop(),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 22,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  */
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
