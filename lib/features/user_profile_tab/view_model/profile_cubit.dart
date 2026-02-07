import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_profile_tab/data/profile_user.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());


  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    File? image,
  }) async {
    emit(ProfileLoading());
    try {
      final data = await repository.updateProfile(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        image: image,
      );
      emit(ProfileSuccess(userData: data["user"], message: data["message"] ?? "Profile updated"));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
