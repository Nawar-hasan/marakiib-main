import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/user_profile_tab/data/profile_user.dart';
import 'package:marakiib_app/features/user_profile_tab/data/user_service.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/profile_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_state.dart';
import 'edit_profile.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(ProfileRepository(Dio())),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(UserService(Dio()))..fetchUser(),
        ),
      ],
      child: const EditProfile(),
    );
  }
}
