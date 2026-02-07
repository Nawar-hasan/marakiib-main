import 'package:flutter/material.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class ChatsHeader extends StatelessWidget {
  const ChatsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        translate.chats,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
