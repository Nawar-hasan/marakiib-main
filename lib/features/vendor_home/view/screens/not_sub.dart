import 'package:flutter/material.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import '../../../../core/themeing/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class NotSub extends StatelessWidget {
  const NotSub({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                locale.noActiveSubscription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                locale.subscriptionInfo,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              MyCustomButton(
                color: AppTheme.black,
                text: locale.profile,
                voidCallback: () {
                  context.push('/ProfileScreen');
                },
              ),
              const SizedBox(height: 10),

              MyCustomButton(
                color: AppTheme.black,
                text: locale.topUpFirst,
                voidCallback: () {
                  context.push('/WalletScreen');
                },
              ),
              const SizedBox(height: 10),
              MyCustomButton(
                text: locale.subscribeNow,
                voidCallback: () {
                  context.push('/SubscriptionScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
