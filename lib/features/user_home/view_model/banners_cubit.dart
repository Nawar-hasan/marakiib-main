import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_home/data/repository/banners_repo.dart';
import 'package:marakiib_app/features/user_home/view_model/banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  final BannersRepo repo;

  BannersCubit(this.repo) : super(BannersInitial());

  Future<void> fetchBanners(String locale) async {
    emit(BannersLoading());
    try {
      final banners = await repo.getBanners(locale);

      if (isClosed) {
        return;
      }

      emit(BannersLoaded(banners));
    } catch (e) {
      if (isClosed) return;

      emit(BannersError(e.toString()));
    }
  }
}
