import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/chat/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final int currentUserId;

  const MessageBubble({
    super.key,
    required this.message,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSender = message.senderId == currentUserId;

    final bgColor = isSender ? AppTheme.primary : AppTheme.gray1010;
    final align = isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textColor = isSender ? AppTheme.white : AppTheme.black;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message.message,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Text(
            _formatTime(message.createdAt),
            style: TextStyle(fontSize: 10.sp, color: AppTheme.gray400),
          ),
        ),
      ],
    );
  }

  String _formatTime(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return createdAt;
    }
  }
}
