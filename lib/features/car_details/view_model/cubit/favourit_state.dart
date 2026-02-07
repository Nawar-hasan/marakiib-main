abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {}

class FavouriteFailure extends FavouriteState {
  final String error;

  FavouriteFailure(this.error);
}
