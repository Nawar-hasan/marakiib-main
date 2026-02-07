import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';

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
              child: CachedNetworkImage(
                imageUrl: images[index], // رابط الصورة من النت
                width: 95.w, // لو موجود
                height: 64.h, // لو موجود
                fit: BoxFit.contain,
                placeholder:
                    (context, url) => Center(child: LoadingIndicator()),
                errorWidget:
                    (context, url, error) => Image.network(
                      "https://ih1.redbubble.net/image.4905811472.8675/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
                      width: 95.w,
                      height: 64.h,
                      fit: BoxFit.contain,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
