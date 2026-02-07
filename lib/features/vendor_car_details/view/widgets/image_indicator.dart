import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;
  final Function(int index) onDotClick;

  const ImageIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
    required this.onDotClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: count,
      effect: const WormEffect(
        dotColor: Colors.grey,
        activeDotColor: Colors.red,
        dotHeight: 8,
        dotWidth: 8,
      ),
      onDotClicked: onDotClick,
    );
  }
}
