import 'package:marakiib_app/features/user_profile_tab/data/favourites_model.dart';

abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesSuccess extends FavouritesState {
  final List<FavouriteModel> favourites;
  FavouritesSuccess(this.favourites);
}
