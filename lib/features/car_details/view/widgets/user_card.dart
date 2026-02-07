import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int userid;
  final bool isLoading;
  final VoidCallback? onChatPressed;

  const UserCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.userid,
    this.isLoading = false,
    this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          CircleImage(imageUrl: imageUrl),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(name, style: Theme.of(context).textTheme.titleMedium),
          ),
          IconButton(
            icon: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primary),
                color: Colors.transparent,
              ),
              child:
                  isLoading
                      ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: LoadingIndicator(),
                      )
                      : HugeIcon(
                        icon: HugeIcons.strokeRoundedBubbleChat,
                        color: AppTheme.primary,
                        size: 24.sp,
                      ),
            ),
            onPressed: isLoading ? null : onChatPressed,
          ),
        ],
      ),
    );
  }
}
