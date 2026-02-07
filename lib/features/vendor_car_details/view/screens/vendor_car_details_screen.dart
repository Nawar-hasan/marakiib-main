import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_car_details/view/data/reviews_repo.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/car_details_info.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/car_features_grid.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/car_image_slider.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/commissions.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/image_indicator.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/image_thumbnails.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/vendor_details_buttons.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/reviews_list1.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/user_card.dart';
import 'package:marakiib_app/features/vendor_car_details/view_model/review_car_cubit.dart';
import 'package:marakiib_app/features/vendor_car_details/view_model/review_car_state.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';

import '../widgets/car_details_header.dart';

// Cubit + Service
import 'package:dio/dio.dart';

class VendorCarDetailsScreen extends StatefulWidget {
  final VendorCarModel car;

  const VendorCarDetailsScreen({super.key, required this.car});

  @override
  State<VendorCarDetailsScreen> createState() => _VendorCarDetailsScreenState();
}

class _VendorCarDetailsScreenState extends State<VendorCarDetailsScreen> {
  final CarouselSliderController _pageController = CarouselSliderController();
  int _currentIndex = 0;

  void _onImageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _jumpToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _onImageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<String> images = [
      if (widget.car.image != null) widget.car.image!,
      ...(widget.car.extraImages ?? <String>[]),
    ];

    return BlocProvider(
      create:
          (_) =>
      CarReviewCubit(CarReviewService(Dio()))
        ..getCarReviews(widget.car.id),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(l10n.carDetails),
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Image Slider Section
                      CarImageSlider(
                        images:
                        images.isNotEmpty
                            ? images
                            : ['assets/images/car.png'],
                        controller: _pageController,
                        onChanged: _onImageChanged,
                      ),
                      SizedBox(height: 10.h),
                      ImageIndicator(
                        count: images.isNotEmpty ? images.length : 1,
                        currentIndex: _currentIndex,
                        onDotClick: _jumpToPage,
                      ),
                      SizedBox(height: 16.h),
                      ImageThumbnails(
                        images:
                        images.isNotEmpty
                            ? images
                            : ['assets/images/car.png'],
                        currentIndex: _currentIndex,
                        onTap: _jumpToPage,
                      ),

                      // Car Information Section
                      SizedBox(height: 50.h),
                      CarDetailsInfo(car: widget.car),

                      // Divider
                      Container(
                        height: 1,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppTheme.gray400,
                        ),
                      ),

                      // Vendor Information
                      UserCard(
                        name: 'Hela Quintin',
                        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                        car: widget.car,
                      ),
                      SizedBox(height: 20.h),

                      CommissionDescriptionWidget(
                        appliesTo: 'seller',
                        plateType: widget.car.plateType,
                      ),
                      SizedBox(height: 5.h),

                      CarFeaturesGrid(car: widget.car),

                      // Reviews Section
                      BlocBuilder<CarReviewCubit, CarReviewState>(
                        builder: (context, state) {
                          if (state is CarReviewLoading) {
                            return Center(
                              child: Column(
                                children: [
                                  const LoadingIndicator(),
                                  SizedBox(height: 16.h),
                                  Text(l10n.loading),
                                ],
                              ),
                            );
                          } else if (state is CarReviewSuccess) {
                            if (state.reviews.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 32.h),
                                child: Center(
                                  child: Text(
                                    l10n.noReviewsYet,
                                    style:
                                    Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  // child: Text(
                                  //   l10n.reviews,
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .headlineSmall
                                  //       ?.copyWith(fontWeight: FontWeight.bold),
                                  // ),

                                ),

                                ReviewsList1(reviews: state.reviews),
                              ],
                            );
                          } else if (state is CarReviewError) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: Center(
                                child: Text(
                                  "${l10n.error}: ${state.error}",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.red),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),

                      // Action Buttons
                      VendorDetailsButtons(car: widget.car),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
