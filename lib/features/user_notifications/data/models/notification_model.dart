class NotificationModel {
  final String title;
  final String message;
  final String time;
  final String iconPath;
  final bool isUnread;
  final String group;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.iconPath,
    required this.isUnread,
    required this.group,
  });
}
