class SendMessageResponse {
  final Message data;

  SendMessageResponse({required this.data});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(data: Message.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {'data': data.toJson()};
  }
}

class Message {
  final int id;
  final int conversationId;
  final int senderId;
  final int receiverId;
  final String message;
  final String? image;
  final String slug;
  final bool isActive;
  final int sortOrder;
  final String updatedAt;
  final String createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.image,
    required this.slug,
    required this.isActive,
    required this.sortOrder,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      message: json['message'] ?? '',
      image: json['image'],
      slug: json['slug'] ?? '',
      isActive: json['is_active'] ?? true,
      sortOrder: json['sort_order'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'image': image,
      'slug': slug,
      'is_active': isActive,
      'sort_order': sortOrder,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
