abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarSuccess extends AddCarState {
  final String message;
  AddCarSuccess(this.message);
}

class AddCarFailure extends AddCarState {
  final String error;
  AddCarFailure(this.error);
}
