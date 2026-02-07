import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

import '../widgets/profile_screen_body.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  translate.profile,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ProfileScreenBody(),
            ],
          ),
        ),
      ),
    );
  }
}
