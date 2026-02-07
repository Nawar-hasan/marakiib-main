abstract class IsFavouriteState {}

class IsFavouriteInitial extends IsFavouriteState {}

class IsFavouriteLoading extends IsFavouriteState {}

class IsFavouriteLoaded extends IsFavouriteState {
  final bool isFavorite;
  final int carId;

  IsFavouriteLoaded({required this.isFavorite, required this.carId});
}

class IsFavouriteError extends IsFavouriteState {
  final String message;

  IsFavouriteError(this.message);
}
