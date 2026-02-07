import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';

abstract class ConversationsState {
  const ConversationsState();
}

class ConversationsInitial extends ConversationsState {}

class ConversationsLoading extends ConversationsState {}

class ConversationsSuccess extends ConversationsState {
  final List<Conversation> conversations;

  const ConversationsSuccess(this.conversations);
}

class ConversationsFailure extends ConversationsState {
  final String error;

  const ConversationsFailure(this.error);
}
