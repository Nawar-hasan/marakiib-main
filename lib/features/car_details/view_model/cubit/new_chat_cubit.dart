import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/car_details/data/repository/new_chat_repo.dart';
import 'new_chat_state.dart';

class NewChatCubit extends Cubit<NewChatState> {
  final NewChatRepo newChatRepo;

  NewChatCubit({required this.newChatRepo}) : super(NewChatInitial());

  Future<void> createChat({required int receiverId}) async {
    emit(NewChatLoading());
    try {
      final conversation = await newChatRepo.createChat(receiverId: receiverId);
      emit(NewChatSuccess(conversation));
    } catch (e) {
      emit(NewChatFailure(e.toString()));
    }
  }
}
