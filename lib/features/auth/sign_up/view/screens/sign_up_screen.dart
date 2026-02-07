import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/themeing/app_theme.dart';
import '../../view_model/user_register_cubit.dart';
import '../data/data_source/register_service.dart';
import '../widgets/sign_up_screen_body.dart';
import 'package:dio/dio.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserRegisterCubit(UserRegisterRepository(Dio())),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.white,

          appBar: AppBar(backgroundColor: AppTheme.gray1),
          body: const SignUpScreenBody(),
        ),
      ),
    );
  }
}
