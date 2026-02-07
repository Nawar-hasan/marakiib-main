class GetNotificationModel {
  final int id;
  final String type;
  final String title;
  final String message;
  final bool isRead;
  final String createdAt;

  GetNotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) {
    return GetNotificationModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'],
      createdAt: json['created_at'],
    );
  }

  // 🟢 Getter جديد لحساب المجموعة
  String get group {
    final now = DateTime.now();
    final date = DateTime.parse(createdAt);
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return "Today";
    } else {
      return "Previous";
    }
  }

  // 🟢 إضافة copyWith لتحديث isRead أو خصائص أخرى بسهولة
  GetNotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    bool? isRead,
    String? createdAt,
  }) {
    return GetNotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
