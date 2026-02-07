import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String imageUrl;
  final VoidCallback? onCall;
  final VoidCallback? onVideoCall;

  const ChatAppBar({
    super.key,
    required this.userName,
    required this.imageUrl,
    this.onCall,
    this.onVideoCall,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: AppTheme.gray1,
      elevation: 0,
      leading: CustomIconButton(
        backgroundColor: Colors.transparent,
        boxShadow: [BoxShadow(color: Colors.transparent)],
        icon: Icons.arrow_back,
        onTap: () {
          context.pop();
        },
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleImage(radius: 20.r, imageUrl: imageUrl),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
