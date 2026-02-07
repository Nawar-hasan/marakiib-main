import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/choose_language_screen_body.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChooseLanguageScreenBody(),
      ),
    );
  }
}
