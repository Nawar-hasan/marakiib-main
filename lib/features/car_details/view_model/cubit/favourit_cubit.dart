import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/car_details/data/repository/favourit_repo.dart';
import 'favourit_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo favouriteRepo;

  FavouriteCubit({required this.favouriteRepo}) : super(FavouriteInitial());

  /// Toggle Favourite
  Future<void> toggleFavourite({required int carId}) async {
    try {
      emit(FavouriteLoading());

      final success = await favouriteRepo.toggleFavourite(carId: carId);

      if (success) {
        emit(FavouriteSuccess());
      } else {
        emit(FavouriteFailure('فشل في تحديث المفضلة'));
      }
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }
}
