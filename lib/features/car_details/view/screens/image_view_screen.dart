import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageViewScreen extends StatefulWidget {
  final String image;

  const ImageViewScreen({super.key, required this.image});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  Offset _offset = Offset.zero;

  final String errorImage =
      "https://ih1.redbubble.net/image.4905811472.8675/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (details) {
              if (details.delta.dy.abs() > details.delta.dx.abs()) {
                setState(() {
                  _offset += details.delta;
                });
              }
            },
            onVerticalDragEnd: (details) {
              if (_offset.dy.abs() > 100) {
                Navigator.of(context).pop();
              } else {
                setState(() => _offset = Offset.zero);
              }
            },
            child: Transform.translate(
              offset: _offset,
              child: Center(
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(widget.image),
                  loadingBuilder:
                      (context, event) =>
                          const Center(child: LoadingIndicator()),
                  errorBuilder:
                      (context, error, stackTrace) => CachedNetworkImage(
                        imageUrl: errorImage,
                        fit: BoxFit.contain,
                      ),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 58.h,
            left: 24.w,
            child: CustomIconButton(
              icon: Icons.arrow_back,
              onTap: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
