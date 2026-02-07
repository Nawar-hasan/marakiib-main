import 'package:flutter/material.dart';
  import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitWaveSpinner(
        color: AppTheme.primary,
        size: 70.0,
        waveColor: AppTheme.primary,
        trackColor: Colors.white, 
      ),
    );
  }
}
