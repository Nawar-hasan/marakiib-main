import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/messages/data/repository/conversations_repo.dart';
import 'package:marakiib_app/features/messages/view/widgets/chat%20header.dart';
import 'package:marakiib_app/features/messages/view/widgets/chat_card.dart';
import 'package:marakiib_app/features/messages/view_model/cubit/view_conversations_cubit.dart';
import 'package:marakiib_app/features/messages/view_model/cubit/view_conversations_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late ConversationsCubit _conversationsCubit;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _conversationsCubit = ConversationsCubit(
      conversationsRepo: ConversationsRepo(dio: Dio()),
    );

    // أول مرة نجلب المحادثات مع اللودنج
    _conversationsCubit.getChatMessages();

    // Polling كل 5 ثواني بدون ظهور اللودنج
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _conversationsCubit.getChatMessages(showLoading: false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _conversationsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: _conversationsCubit,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ChatsHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ConversationsCubit, ConversationsState>(
                  builder: (context, state) {
                    if (state is ConversationsLoading) {
                      return const LoadingIndicator();
                    } else if (state is ConversationsFailure) {
                      return Center(child: Text(state.error));
                    } else if (state is ConversationsSuccess) {
                      if (state.conversations.isEmpty) {
                        return Center(
                          child: Text(
                            translate.noMessagesYet,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppTheme.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.conversations.length,
                        itemBuilder: (context, index) {
                          final message = state.conversations[index];
                          return ChatCard(conversation: message);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
