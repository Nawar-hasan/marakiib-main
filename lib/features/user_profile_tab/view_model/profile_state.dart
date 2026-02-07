import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Map<String, dynamic> userData;
  final String message;

  ProfileSuccess({required this.userData, required this.message});
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}
