abstract class PrivateRenterRegisterState {}

class PrivateRenterRegisterInitial extends PrivateRenterRegisterState {}

class PrivateRenterRegisterLoading extends PrivateRenterRegisterState {}

class PrivateRenterRegisterSuccess extends PrivateRenterRegisterState {
  final String message;
  PrivateRenterRegisterSuccess(this.message);
}

class PrivateRenterRegisterFailure extends PrivateRenterRegisterState {
  final String error;
  PrivateRenterRegisterFailure(this.error);
}
