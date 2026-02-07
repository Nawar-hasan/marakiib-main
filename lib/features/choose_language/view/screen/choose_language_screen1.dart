import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marakiib_app/features/choose_language/view/widgets/choose_language_screen_body1.dart';

import '../widgets/choose_language_screen_body.dart';

class ChooseLanguageScreen1 extends StatelessWidget {
  const ChooseLanguageScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChooseLanguageScreenBody1(),
      ),
    );
  }
}
