// ======================= User Model =======================
class User {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image": image,
      "role": role,
    };
  }
}

// ======================= Message Model =======================
class Message {
  final int id;
  final int conversationId;
  final int senderId;
  final int receiverId;
  final String message;
  final String? image;
  final String? readAt;
  final String createdAt;
  final User? sender;   // optional
  final User? receiver; // optional

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.image,
    this.readAt,
    required this.createdAt,
    this.sender,
    this.receiver,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      message: json['message'] ?? '',
      image: json['image'],
      readAt: json['read_at'],
      createdAt: json['created_at'] ?? '',
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? User.fromJson(json['receiver']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "conversation_id": conversationId,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "message": message,
      "image": image,
      "read_at": readAt,
      "created_at": createdAt,
      "sender": sender?.toJson(),
      "receiver": receiver?.toJson(),
    };
  }
}

// ======================= Message Response =======================
class MessageResponse {
  final int currentUserId;
  final List<Message> messages;

  MessageResponse({required this.currentUserId, required this.messages});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      currentUserId: json['current_user_id'] ?? 0,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((item) => Message.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_user_id": currentUserId,
      "messages": messages.map((item) => item.toJson()).toList(),
    };
  }

  MessageResponse copyWith({int? currentUserId, List<Message>? messages}) {
    return MessageResponse(
      currentUserId: currentUserId ?? this.currentUserId,
      messages: messages ?? this.messages,
    );
  }
}
