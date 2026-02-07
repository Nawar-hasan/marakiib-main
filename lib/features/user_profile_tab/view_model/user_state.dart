import 'package:marakiib_app/features/user_profile_tab/data/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;
  UserSuccess(this.user);
}

class UserFailure extends UserState {
  final String error;
  UserFailure(this.error);
}
