import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/about_us/data/about_us_repo.dart';
import 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  final AboutUsRepository repository;

  AboutUsCubit(this.repository) : super(AboutUsInitial());

  Future<void> fetchAboutUs() async {
    emit(AboutUsLoading());
    try {
      final aboutUs = await repository.getAboutUs();
      emit(AboutUsSuccess(aboutUs));
    } catch (e) {
      emit(AboutUsError(e.toString()));
    }
  }
}
