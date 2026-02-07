abstract class UserRegisterState {}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterLoading extends UserRegisterState {}

class UserRegisterSuccess extends UserRegisterState {
  final String message;
  UserRegisterSuccess(this.message);
}

class UserRegisterFailure extends UserRegisterState {
  final String error;
  UserRegisterFailure(this.error);
}
