abstract class RentalOfficeRegisterState {}

class RentalOfficeRegisterInitial extends RentalOfficeRegisterState {}

class RentalOfficeRegisterLoading extends RentalOfficeRegisterState {}

class RentalOfficeRegisterSuccess extends RentalOfficeRegisterState {
  final String message;
  RentalOfficeRegisterSuccess(this.message);
}

class RentalOfficeRegisterFailure extends RentalOfficeRegisterState {
  final String error;
  RentalOfficeRegisterFailure(this.error);
}
