class UnreadCountModel {
  final int unreadCount;

  UnreadCountModel({required this.unreadCount});

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) {
    return UnreadCountModel(
      unreadCount: json['unread_count'] ?? 0,
    );
  }
}
