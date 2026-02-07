import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

import '../../view_model/login_cubit.dart';
import '../data/login_repository.dart';
import '../widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: Center(
          child: BlocProvider(
            create: (context) => LoginCubit(LoginRepository(Dio())),
            child: LoginScreenBody(),
          ),
        ),
      ),
    );
  }
}
