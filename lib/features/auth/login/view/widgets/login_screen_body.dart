import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_textFild.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../sign_up/view/widgets/social _auth.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_state.dart';
import '../data/login_model.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.error),
          );
        } else if (state is LoginSuccess) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: 'تم تسجيل الدخول بنجاح'),
          );

          final role = state.userData["role"];
          final token = state.token;

          if (role == "customer") {
            context.go(AppRoutes.userNavBar);
          }
          else if (role == "rental_office") {
            context.go(AppRoutes.VendorNavBarView);
          }
          else if (role == "private_renter") {

            final hasSubscription = await context
                .read<LoginCubit>()
                .checkSubscriptionStatus(token);

            if (hasSubscription) {
              context.go(AppRoutes.VendorNavBarView);
            } else {
              context.go('/NotSub');
            }
          }
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
                  AppLocalizations.of(context)!.loginTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: AppTheme.primary),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30.h),

                CustomTextField(
                  taskController: emailController,
                  hint: AppLocalizations.of(context)!.emailHint1,
                  icon: Icons.email,

                ),
                SizedBox(height: 20.h),

                CustomTextField(
                  taskController: passwordController,
                  hint: AppLocalizations.of(context)!.passwordHint,
                  icon: Icons.lock,
                  ispassword: true,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.passwordRequired;
                    }
                    if (value.length < 6) {
                      return AppLocalizations.of(context)!.passwordTooShort;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),

                GestureDetector(
                  onTap: () => context.push('/ForgetPasswordScreen'),
                  child: Align(
                    alignment:
                    isArabic ? Alignment.centerLeft : Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: GoogleFonts.montserrat(
                        color: AppTheme.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                state is LoginLoading
                    ? const LoadingIndicator()
                    : MyCustomButton(
                  text: AppLocalizations.of(context)!.signInBtn,
                  width: double.infinity,
                  height: 52.h,
                  radius: 12.r,
                  fontSize: 16.sp,
                  color: AppTheme.black,
                  textColor: AppTheme.white,
                  borderColor: AppTheme.black,
                  voidCallback: () {
                    if (_formKey.currentState!.validate()) {
                      final loginModel = LoginModel(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      context.read<LoginCubit>().login(loginModel);
                    }
                  },
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppTheme.gray100, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        AppLocalizations.of(context)!.orSignInWith,
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

                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: AppTheme.black,
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(text: AppLocalizations.of(context)!.noAccount),
                        WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(
                          text: AppLocalizations.of(context)!.signUp,
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SafeArea(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 30.h,
                                          ),
                                          padding: EdgeInsets.only(
                                            left: 20.w,
                                            right: 20.w,
                                            bottom:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom +
                                                20.h,
                                            top: 20.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.vertical(
                                              top: Radius.circular(
                                                20.r,
                                              ),
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
                                                  BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.chooseAccountType,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 30.h),
                                              MyCustomButton(
                                                text:
                                                AppLocalizations.of(
                                                  context,
                                                )!.userBtn,
                                                width: double.infinity,
                                                height: 52.h,
                                                radius: 12.r,
                                                fontSize: 16.sp,
                                                color: AppTheme.primary,
                                                textColor: Colors.white,
                                                borderColor:
                                                AppTheme.primary,
                                                voidCallback: () {
                                                  Navigator.pop(context);
                                                  context.push(
                                                    '/SignUpScreen',
                                                  );
                                                },
                                              ),
                                              SizedBox(height: 12.h),
                                              MyCustomButton(
                                                text:
                                                AppLocalizations.of(
                                                  context,
                                                )!.vendorBtn,
                                                width: double.infinity,
                                                height: 52.h,
                                                radius: 12.r,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                                textColor: AppTheme.primary,
                                                borderColor:
                                                AppTheme.primary,
                                                voidCallback: () {
                                                  Navigator.pop(context);
                                                  context.push(
                                                    AppRoutes.SignUpVendor,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -20,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap:
                                              () =>
                                              Navigator.of(
                                                context,
                                              ).pop(),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
