import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

import '../../view_model/private_renter_register_cubit.dart';
import '../data/data_source/private_renter_register_repository.dart';
import '../widgets/sign_up_vendor_body.dart';

class SignUpVendor extends StatelessWidget {
  const SignUpVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) => PrivateRenterRegisterCubit(
                  PrivateRenterRegisterRepository(Dio()),
                ),
          ),
          // BlocProvider(
          //   create: (_) => VendorRegisterCubit(),
          // ),
        ],
        child: Scaffold(
          backgroundColor: AppTheme.white,

          appBar: AppBar(backgroundColor: AppTheme.gray1),
          body: const SignUpVendorBody(),
        ),
      ),
    );
  }
}
