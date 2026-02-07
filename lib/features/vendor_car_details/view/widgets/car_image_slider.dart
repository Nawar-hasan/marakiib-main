import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';

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
            context.push(AppRoutes.ImageViewScreen, extra: images[index]);
          },
          child: Image.network(images[index], fit: BoxFit.contain),
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
