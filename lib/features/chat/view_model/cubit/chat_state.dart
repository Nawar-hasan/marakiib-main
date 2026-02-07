import 'package:marakiib_app/features/chat/data/models/message_model.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageSuccess extends MessageState {
  final MessageResponse messageResponse;

  MessageSuccess(this.messageResponse);
}

class MessageFailure extends MessageState {
  final String error;

  MessageFailure(this.error);
}

// ✅ Conversation marked as read
class MessageReadSuccess extends MessageState {}

class MessageRefreshed extends MessageState {
  final MessageResponse messageResponse;

  MessageRefreshed(this.messageResponse);
}

// ✅ Message successfully sent
class MessageSent extends MessageState {
  final Message newMessage;
  final int currentUserId;

  MessageSent({required this.newMessage, required this.currentUserId});
}
