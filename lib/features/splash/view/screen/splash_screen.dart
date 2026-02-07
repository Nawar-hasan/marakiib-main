import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

import '../widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.black,
        body: SplashBody(),
      ),
    );
  }
}
