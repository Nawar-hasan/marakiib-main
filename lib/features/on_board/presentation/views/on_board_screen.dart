import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/themeing/app_theme.dart';
import '../view_model/view_model.dart';

class OnBoardViewBody extends StatefulWidget {
  const OnBoardViewBody({super.key});

  @override
  State<OnBoardViewBody> createState() => _OnBoardViewBodyState();
}

class _OnBoardViewBodyState extends State<OnBoardViewBody> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, state) {
          var cubit = OnBoardingCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              top: false,
              right: false,
              left: false,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) => cubit.changePage(index),
                    itemCount: cubit.pages.length,
                    itemBuilder: (context, index) {
                      final page = cubit.pages[index];

                      String title =
                          "We Prioritize Your Safety and Enjoyment of Your Trip";
                      String description =
                          "Each of our cars has undergone detailed inspection and maintenance to ensure the enjoyment and safety of your trip.";

                      if (index == 1) {
                        title = "Start Your Fun Adventure with Marakiib";
                        description =
                        "The best selection of cars to suit your needs. From family cars to sporty ones, we have everything you're looking for.";
                      } else if (index == 2) {
                        title = "Easy Payment Process with Marakiib";
                        description =
                        "We understand that your time is valuable. Our payment process is fast and secure, ensuring you can hit the road quickly without any hassle.";
                      }

                      return Column(
                        children: [
                          ClipPath(
                            clipper: BottomOvalClipper(),
                            child: Container(
                              height: 450.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  radius: 1.2,
                                  colors: [
                                    AppTheme.primary.withOpacity(0.8),
                                    AppTheme.primary,
                                    AppTheme.primary.withOpacity(0.9),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -150.w,
                                    top: 60.h,
                                    bottom: 60.h,
                                    child: AnimatedBuilder(
                                      animation: pageController,
                                      builder: (context, child) {
                                        double value = 1;
                                        if (pageController.hasClients) {
                                          value = (1 -
                                              ((pageController.page ?? index) - index)
                                                  .abs() *
                                                  0.5)
                                              .clamp(0.0, 1.0);
                                        }

                                        return Transform.translate(
                                          offset: Offset(0, (1 - value) * 200),
                                          child: Opacity(
                                            opacity: value,
                                            child: SizedBox(
                                              child: Image.asset(page.image),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  const Spacer(),

                                  Row(
                                    children: [
                                      if (state > 0)
                                        Container(
                                          width: 50.w,
                                          height: 50.h,
                                          margin: EdgeInsets.only(left: 16.w),
                                          decoration: const BoxDecoration(
                                            color: AppTheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(30.r),
                                              onTap: () {
                                                pageController.previousPage(
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.white,
                                                size: 26.sp,
                                              ),
                                            ),
                                          ),
                                        ),

                                      Expanded(
                                        child: Center(
                                          child: SmoothPageIndicator(
                                            controller: pageController,
                                            count: cubit.pages.length,
                                            effect: ExpandingDotsEffect(
                                              activeDotColor: AppTheme.primary,
                                              dotColor: Colors.grey[300]!,
                                              dotHeight: 8.h,
                                              dotWidth: 8.w,
                                              expansionFactor: 3,
                                              spacing: 8.w,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        margin: EdgeInsets.only(right: 16.w),
                                        decoration: const BoxDecoration(
                                          color: AppTheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30.r),
                                            onTap: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              if (state < cubit.pages.length - 1) {
                                                pageController.nextPage(
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              } else {
                                                await prefs.setBool("onBoarding_completed", true);
                                                context.go('/ChooseLanguageScreen');
                                              }
                                            },
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 26.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Positioned(
                    top: 50.h,
                    right: 20.w,
                    child: TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool("onBoarding_completed", true);
                        context.go('/ChooseLanguageScreen');
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40.h);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40.h,
      size.width,
      size.height - 40.h,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
