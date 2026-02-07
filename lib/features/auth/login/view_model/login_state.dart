import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/data/login_model.dart';
import '../view/data/login_repository.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final Map<String, dynamic> userData;
  final String token;

  LoginSuccess({
    required this.message,
    required this.userData,
    required this.token,
  });
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

