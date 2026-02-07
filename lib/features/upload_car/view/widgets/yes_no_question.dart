import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';


class YesNoQuestionWidget extends StatelessWidget {
  final String question;
  final bool value;
  final Function(bool) onChanged;

  const YesNoQuestionWidget({
    super.key,
    required this.question,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: value,
              activeColor: AppTheme.primary,
              onChanged: (val) => onChanged(val ?? true),
            ),
            Text(l10n.yes, style: Theme.of(context).textTheme.titleSmall),
            SizedBox(width: 16.w),
            Radio<bool>(
              value: false,
              groupValue: value,
              activeColor: AppTheme.primary,
              onChanged: (val) => onChanged(val ?? false),
            ),
            Text(l10n.no, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ],
    );
  }
}
