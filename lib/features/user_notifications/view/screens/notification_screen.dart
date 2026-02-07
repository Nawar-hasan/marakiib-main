// notification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_notifications/view_model/get_notification_cubit.dart';
import 'package:marakiib_app/features/user_notifications/view_model/get_notification_state.dart';
import 'package:marakiib_app/features/user_notifications/view/data/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          translate.notification,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is NotificationFailure) {
            return Center(child: Text(state.error));
          } else if (state is NotificationSuccess) {
            final notifications = state.notifications;

            if (notifications.isEmpty) {
              return _buildEmptyState(context);
            }

            final today =
            notifications.where((n) => n.group == "Today").toList();
            final previous =
            notifications.where((n) => n.group == "Previous").toList();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (today.isNotEmpty) ...[
                    Text(
                      translate.today ?? "Today",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...today.map((n) => NotificationItem(notification: n)),
                    SizedBox(height: 16.h),
                  ],
                  if (previous.isNotEmpty) ...[
                    Text(
                      translate.previous ?? "Previous",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...previous.map((n) => NotificationItem(notification: n)),
                  ],
                ],
              ),
            );
          }

          return _buildEmptyState(context);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Notification.json',
              height: 200.h,
              width: 200.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24.h),
            Text(
              translate.noNotifications ?? 'مفيش إشعارات دلوقتي 🔕',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.gray200,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final GetNotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!notification.isRead) {
          await context.read<NotificationCubit>().markAsRead(notification);
          // بعد ما تعمل markAsRead نحدث البيانات عشان تظهر الفورًا
          context.read<NotificationCubit>().getNotifications();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          color: AppTheme.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications, color: Colors.grey, size: 20.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  notification.createdAt.split('T')[0],
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppTheme.gray200),
                ),
                SizedBox(height: 5.h),
                if (!notification.isRead)
                  CircleAvatar(backgroundColor: Colors.blue, radius: 5.r),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
