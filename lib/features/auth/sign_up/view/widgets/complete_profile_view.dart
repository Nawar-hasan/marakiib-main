import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_date.dart';
import 'package:marakiib_app/core/widgets/custom_textFild.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/otp_dailog.dart';
import 'package:marakiib_app/core/widgets/phone_number_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../data/data_source/private_renter_register_repository.dart';
import '../data/model/private_renter_register_model.dart';
import '../../view_model/private_renter_register_cubit.dart';
import '../../view_model/private_renter_register_state.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController licenseExpiryController = TextEditingController();

  File? licenseImage;

  Future<void> pickLicenseImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        licenseImage = File(picked.path);
      });
    }
  }

  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PrivateRenterRegisterCubit(PrivateRenterRegisterRepository(Dio())),
      child: BlocConsumer<PrivateRenterRegisterCubit,
          PrivateRenterRegisterState>(
        listener: (context, state) {
          if (state is PrivateRenterRegisterSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                  message: 'تم حفظ البيانات بنجاح ✅'),
            );
            context.go('/vendorNavBar');
          } else if (state is PrivateRenterRegisterFailure) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.error),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('إكمال البيانات'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomPhoneField(
                      controller: phoneController,
                      label: 'رقم الهاتف',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل رقم الهاتف';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      taskController: addressController,
                      hint: 'العنوان',
                      icon: Icons.location_on,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل العنوان';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'صورة رخصة القيادة',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

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
                                    ? 'اختر صورة الرخصة'
                                    : 'تم اختيار الصورة',
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
                            text: 'رفع الصورة',
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
                      labelText: 'تاريخ انتهاء الرخصة',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك اختر تاريخ انتهاء الرخصة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // TODO: لاحقًا ممكن تضيف location picker هنا 👇
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextField(
                    //         taskController: TextEditingController(
                    //             text: latitude.toString()),
                    //         hint: 'Latitude',
                    //         icon: Icons.location_searching,
                    //         validate: (_) => null,
                    //         enabled: false,
                    //       ),
                    //     ),
                    //     SizedBox(width: 10.w),
                    //     Expanded(
                    //       child: CustomTextField(
                    //         taskController: TextEditingController(
                    //             text: longitude.toString()),
                    //         hint: 'Longitude',
                    //         icon: Icons.explore,
                    //         validate: (_) => null,
                    //         enabled: false,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 30.h),

                    MyCustomButton(
                      text: state is PrivateRenterRegisterLoading
                          ? 'جاري الحفظ...'
                          : 'حفظ البيانات',
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
                              const SnackBar(
                                  content: Text('من فضلك اختر صورة الرخصة')),
                            );
                            return;
                          }

                          // ======= نفتح الـ OTP Dialog =======
                          final selectedOtp = await OtpMethodDialog.show(context);
                          if (selectedOtp == null) return; // لو المستخدم ضغط إلغاء

                          // ======= نعمل الـ Model مع otpMethod =======
                          final user = PrivateRenterRegisterModel(
                            name: '',
                            email: '',
                            password: '',
                            passwordConfirmation: '',
                            phoneNumber: phoneController.text,
                            address: addressController.text,
                            latitude: latitude,
                            longitude: longitude,
                            role: 'private_renter',
                            carLicenseImage: licenseImage!.path,
                            carLicenseExpiryDate: licenseExpiryController.text,
                            otpMethod: selectedOtp.name, // هنا القيمة المختارة
                          );

                          // ======= لو عندك Cubit نبعته هنا =======
                          context.read<PrivateRenterRegisterCubit>().register(user);
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
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
