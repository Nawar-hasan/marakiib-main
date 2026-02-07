import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/privacy/data/privacy_repository.dart';
import 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  final PrivacyRepository repository;

  PrivacyCubit(this.repository) : super(PrivacyInitial());

  Future<void> getPrivacyPage() async {
    emit(PrivacyLoading());
    try {
      final privacy = await repository.getPrivacyPage();
      emit(PrivacySuccess(privacy));
    } catch (e) {
      emit(PrivacyError(e.toString()));
    }
  }
}
