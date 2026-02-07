import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';

class CarImageSlider extends StatelessWidget {
  final List<String> images;
  final CarouselSliderController controller;
  final Function(int index) onChanged;

  const CarImageSlider({
    super.key,
    required this.images,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            if (images[index] != null) {
              context.push(AppRoutes.ImageViewScreen, extra: images[index]);
            }
          },
          child: CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.contain,
            placeholder: (context, url) => Center(child: LoadingIndicator()),
            errorWidget:
                (context, url, error) => Image.network(
                  "https://ih1.redbubble.net/image.4905811472.8675/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
                  fit: BoxFit.contain,
                ),
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlay: true,
        reverse: true,
        onPageChanged: (index, reason) => onChanged(index),
      ),
    );
  }
}
