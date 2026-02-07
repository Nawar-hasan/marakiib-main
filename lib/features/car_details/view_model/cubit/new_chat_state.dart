import 'package:marakiib_app/features/car_details/data/models/new_chat_model.dart';

abstract class NewChatState {}

class NewChatInitial extends NewChatState {}

class NewChatLoading extends NewChatState {}

class NewChatSuccess extends NewChatState {
  final NewChatModel conversation;
  NewChatSuccess(this.conversation);
}

class NewChatFailure extends NewChatState {
  final String error;
  NewChatFailure(this.error);
}
