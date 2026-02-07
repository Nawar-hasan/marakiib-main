import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/messages/data/repository/conversations_repo.dart';
import 'package:marakiib_app/features/messages/view_model/cubit/view_conversations_state.dart';
import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  final ConversationsRepo conversationsRepo;

  ConversationsCubit({required this.conversationsRepo})
    : super(ConversationsInitial());

  // ✅ جلب كل المحادثات
  Future<void> getChatMessages({bool showLoading = true}) async {
    if (showLoading) emit(ConversationsLoading());
    try {
      final response = await conversationsRepo.getChatMessages();
      if (isClosed) return;
      emit(ConversationsSuccess(response));
    } catch (e) {
      if (isClosed) return;
      emit(ConversationsFailure(e.toString()));
    }
  }

  void updateConversation(Conversation updatedConversation) {
    if (state is ConversationsSuccess) {
      final currentList = (state as ConversationsSuccess).conversations;
      final updatedList =
          currentList
              .map(
                (c) => c.id == updatedConversation.id ? updatedConversation : c,
              )
              .toList();
      emit(ConversationsSuccess(updatedList));
    }
  }
}
