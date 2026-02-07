import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_profile_tab/data/support_repo.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final SupportRepository repository;

  SupportCubit(this.repository) : super(SupportInitial());

  Future<void> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(SupportLoading());
    try {
      final response = await repository.sendSupportMessage(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      emit(SupportSuccess(response));
    } catch (e) {
      emit(SupportError(e.toString()));
    }
  }
}
