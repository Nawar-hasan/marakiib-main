import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/chat/data/repository/messages_repo.dart';
import 'package:marakiib_app/features/chat/view_model/cubit/chat_cubit.dart';
import 'package:marakiib_app/features/chat/view_model/cubit/chat_state.dart';
import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';
import 'package:marakiib_app/features/messages/view/widgets/chat_app_bar.dart';
import 'package:marakiib_app/features/chat/view/widgets/message_bubble.dart';
import 'package:marakiib_app/features/chat/view/widgets/message_input_field.dart';

class ChatScreen extends StatefulWidget {
  final ChaTData chaTData;

  const ChatScreen({super.key, required this.chaTData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? _timer;
  late MessageCubit _messageCubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _messageCubit = MessageCubit(messageRepo: MessageRepo(dio: Dio()));

    // أول ما يدخل المحادثة نعلم إنها اتقرت
    _messageCubit.markConversationAsRead(widget.chaTData.id);

    // بعدها نجيب الرسائل
    _messageCubit.getMessages(widget.chaTData.id);

    // polling للرسائل كل 5 ثواني
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _messageCubit.getMessages(widget.chaTData.id, isRefresh: true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _messageCubit.close();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _messageCubit.sendMessage(widget.chaTData.id, text);
      _controller.clear();
      _scrollToBottom();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _messageCubit,
      child: Scaffold(
        appBar: ChatAppBar(
          userName: widget.chaTData.name,
          imageUrl: widget.chaTData.image,
        ),
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<MessageCubit, MessageState>(
                  listener: (context, state) {
                    if (state is MessageSuccess || state is MessageRefreshed) {
                      _scrollToBottom();
                    }
                  },
                  builder: (context, state) {
                    if (state is MessageLoading) {
                      return const LoadingIndicator();
                    } else if (state is MessageSuccess ||
                        state is MessageRefreshed) {
                      final messages =
                          (state is MessageSuccess)
                              ? state.messageResponse.messages
                              : (state as MessageRefreshed)
                                  .messageResponse
                                  .messages;

                      final currentUserId =
                          (state is MessageSuccess)
                              ? state.messageResponse.currentUserId
                              : (state as MessageRefreshed)
                                  .messageResponse
                                  .currentUserId;

                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return MessageBubble(
                            message: message,
                            currentUserId: currentUserId,
                          );
                        },
                      );
                    } else if (state is MessageFailure) {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              MessageInputField(controller: _controller, onSend: _sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}

class ChaTData {
  final String name;
  final String image;
  final int id;
  ChaTData({required this.image, required this.name, required this.id});
}
