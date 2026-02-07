import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class RadioGroupWidget extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final Function(String) onChanged;

  const RadioGroupWidget({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Row(
          children:
              options.map((option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selected,
                      activeColor: AppTheme.primary,
                      onChanged: (val) => onChanged(val ?? selected),
                    ),
                    Text(option),
                    SizedBox(width: 16.w),
                  ],
                );
              }).toList(),
        ),
      ],
    );
  }
}
