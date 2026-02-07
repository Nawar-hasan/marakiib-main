class NewChatModel {
  final int id;
  final int user1Id;
  final int user2Id;
  final int? lastMessageId;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String renterName;

  NewChatModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    this.lastMessageId,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.renterName,
  });

  factory NewChatModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return NewChatModel(
      id: data['id'],
      user1Id: data['user1_id'],
      user2Id: data['user2_id'],
      lastMessageId: data['last_message_id'],
      isActive: data['is_active'] == 1,
      sortOrder: data['sort_order'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      deletedAt:
          data['deleted_at'] != null
              ? DateTime.parse(data['deleted_at'])
              : null,
      renterName: data['renter_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user1_id": user1Id,
    "user2_id": user2Id,
    "last_message_id": lastMessageId,
    "is_active": isActive ? 1 : 0,
    "sort_order": sortOrder,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
    "renter_name": renterName,
  };
}
