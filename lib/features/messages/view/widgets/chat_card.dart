import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/features/chat/view/screens/chat_screen.dart';
import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';
import 'package:marakiib_app/features/chat/view_model/cubit/chat_cubit.dart';

class ChatCard extends StatelessWidget {
  final Conversation conversation;
  const ChatCard({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        final messageCubit = context.read<MessageCubit?>();
        if (messageCubit != null) {
          messageCubit.markConversationAsRead(conversation.id);
        }

        context.push(
          AppRoutes.ChatScreen,
          extra: ChaTData(
            name: conversation.chatWith.name,
            id: conversation.id,
            image:
                conversation.chatWith.image ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8PyKYrBKAWWy6YCbQzWQcwIRqH8wYMPluIZiMpV1w0NYSbocTZz0ICWFkLcXhaMyvCwQ&usqp=CAU",
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.w),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8PyKYrBKAWWy6YCbQzWQcwIRqH8wYMPluIZiMpV1w0NYSbocTZz0ICWFkLcXhaMyvCwQ&usqp=CAU",
              radius: 26,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.chatWith.name,
                    style: textTheme.headlineSmall,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    conversation.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      color: AppTheme.gray400,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                conversation.unreadCount != 0
                    ? Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        conversation.unreadCount.toString(),
                        style: textTheme.titleSmall?.copyWith(
                          fontSize: 12.sp,
                          color: AppTheme.white,
                        ),
                      ),
                    )
                    : SizedBox(height: 28.h),
                SizedBox(height: 4.h),
                Text(
                  "${conversation.lastMessageTime}",
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 12.sp,
                    color: AppTheme.gray400,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
