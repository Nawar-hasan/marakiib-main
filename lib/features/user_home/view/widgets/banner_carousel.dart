import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/localization/localization_bloc.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/repository/banners_repo.dart';
import 'package:marakiib_app/features/user_home/view_model/banners_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/banners_state.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1);
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LanguageCubit>().state.languageCode;

    return BlocProvider(
      create:
          (context) =>
              BannersCubit(BannersRepo(dio: Dio()))..fetchBanners(locale),
      child: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          if (state is BannersLoading) {
            return Container(
              height: 151.h,
              width: double.infinity,
              margin: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.grey.shade200,
              ),
              child: const Center(child: LoadingIndicator()),
            );
          }

          if (state is BannersError) {
            return const SizedBox.shrink();
          }

          if (state is BannersLoaded) {
            final banners = state.banners;

            if (banners.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
              height: 151.h,
              margin: EdgeInsets.all(12.sp),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index % banners.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      final banner = banners[index % banners.length];
                      return _BannerItem(banner: banner);
                    },
                  ),
                  // Page Indicators
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        banners.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: _currentPage == index ? 24.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _BannerItem extends StatelessWidget {
  final dynamic banner;

  const _BannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          CachedNetworkImage(
            imageUrl: banner.backgroundImage,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(child: LoadingIndicator()),
                ),
            errorWidget:
                (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.error, color: Colors.red),
                ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Text Content
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  banner.subtitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  banner.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.white70),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
