import 'package:flutter/material.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class BookingStepper extends StatelessWidget {
  final String currentTitle;

  const BookingStepper({super.key, required this.currentTitle});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final steps = [
      translate.bookingDetails,
      translate.paymentMethods,
      translate.confirmation,
    ];
    final currentStep = steps.indexOf(currentTitle);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final isActive = index == currentStep;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (index != 0)
                    Expanded(child: Divider(color: Colors.black, thickness: 1)),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: isActive ? Colors.white : Colors.black87,
                    child:
                        isActive
                            ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                            )
                            : null,
                  ),
                  if (index != steps.length - 1)
                    Expanded(child: Divider(color: Colors.black, thickness: 1)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                steps[index],
                style: TextStyle(
                  color: isActive ? AppTheme.primary : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
