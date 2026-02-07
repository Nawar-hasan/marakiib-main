import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/chat/data/models/message_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/features/chat/data/repository/messages_repo.dart';
import 'package:marakiib_app/features/chat/view_model/cubit/chat_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepo messageRepo;

  MessageCubit({required this.messageRepo}) : super(MessageInitial());

  // ✅ Get Messages (with option to refresh without showing loading)
  Future<void> getMessages(int conversationId, {bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(MessageLoading());
    }

    try {
      final response = await messageRepo.getMessages(conversationId);
      if (isClosed) return;

      if (isRefresh && state is MessageSuccess) {
        emit(MessageRefreshed(response));
      } else {
        emit(MessageSuccess(response));
      }
    } on ServerExceptions catch (e) {
      if (isClosed) return;
      emit(MessageFailure(e.errorModel.message));
    } catch (e) {
      if (isClosed) return;
      emit(MessageFailure("Unexpected error: $e"));
    }
  }

  // ✅ Mark as Read
  Future<void> markConversationAsRead(int conversationId) async {
    try {
      await messageRepo.markConversationAsRead(conversationId);
    } on ServerExceptions catch (e) {
      if (isClosed) return;
      emit(MessageFailure(e.errorModel.message));
    } catch (e) {
      if (isClosed) return;
      emit(MessageFailure("Unexpected error: $e"));
    }
  }

  // ✅ Send Message
  Future<void> sendMessage(int conversationId, String text) async {
    if (text.trim().isEmpty) return;

    try {
      // أرسل الرسالة للباك اند
      final newMessage = await messageRepo.sendMessage(conversationId, text);

      // لو الstate الحالي موجود وناجح، أضف الرسالة للـ list مباشرة
      if (state is MessageSuccess) {
        final currentMessages =
            (state as MessageSuccess).messageResponse.messages;
        final updatedMessages = List<Message>.from(currentMessages)
          ..add(newMessage);

        // أبعت الـ state الجديد مع الرسالة المحدثة
        emit(
          MessageSuccess(
            (state as MessageSuccess).messageResponse.copyWith(
              messages: updatedMessages,
            ),
          ),
        );
      } else {
        // لو الـ state مش MessageSuccess، نعمل state جديد مباشرة
        emit(
          MessageSuccess(
            MessageResponse(
              currentUserId: newMessage.senderId,
              messages: [newMessage],
            ),
          ),
        );
      }
    } on ServerExceptions catch (e) {
      if (isClosed) return;
      emit(MessageFailure(e.errorModel.message));
    } catch (e) {
      if (isClosed) return;
      emit(MessageFailure("Unexpected error: $e"));
    }
  }
}
