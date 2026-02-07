import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/user_profile_tab/view/widgets/info_user.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/data/user_service.dart';

class InfoUserWrapper extends StatelessWidget {
  const InfoUserWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(UserService(Dio()))..fetchUser(),
      child: const InfoUser(),
    );
  }
}
