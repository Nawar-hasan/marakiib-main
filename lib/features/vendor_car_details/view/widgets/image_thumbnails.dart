import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageThumbnails extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onTap;

  const ImageThumbnails({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: images.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (_, index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.network(
                images[index],
                width: 95.w,
                height: 64.h,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
