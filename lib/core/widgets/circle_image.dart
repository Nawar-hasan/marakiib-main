import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircleImage({super.key, required this.imageUrl, this.radius = 26.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
