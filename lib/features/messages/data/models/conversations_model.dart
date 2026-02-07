class ConversationsResponse {
  final List<Conversation> data;

  ConversationsResponse({required this.data});

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) {
    return ConversationsResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((item) => Conversation.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"data": data.map((item) => item.toJson()).toList()};
  }
}

class Conversation {
  final int id;
  final ChatUser chatWith;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  Conversation({
    required this.id,
    required this.chatWith,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  Conversation copyWith({
    String? lastMessage,
    String? lastMessageTime,
    int? unreadCount,
  }) {
    return Conversation(
      id: id,
      chatWith: chatWith,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] ?? 0,
      chatWith: ChatUser.fromJson(json['chat_with']),
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] ?? '',
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "chat_with": chatWith.toJson(),
      "last_message": lastMessage,
      "last_message_time": lastMessageTime,
      "unread_count": unreadCount,
    };
  }
}

class ChatUser {
  final int id;
  final String name;
  final String? image;

  ChatUser({required this.id, required this.name, this.image});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "image": image};
  }
}
