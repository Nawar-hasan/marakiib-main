import 'package:flutter/material.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class RentalDateTimeSelection extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const RentalDateTimeSelection({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final List<String> periods = [
      translate.hour,
      translate.day,
      translate.weekly,
      translate.monthly,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.rentalDateTime,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          children:
              periods.map((period) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _buildPeriodButton(period),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String period) {
    final bool isSelected = selectedPeriod == period;

    return GestureDetector(
      onTap: () => onPeriodSelected(period),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          period,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
