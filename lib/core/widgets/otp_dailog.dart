import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import '../themeing/app_theme.dart';

enum OtpMethod { sms, email }

extension OtpMethodExtension on OtpMethod {
  String get name {
    switch (this) {
      case OtpMethod.sms:
        return 'sms';
      case OtpMethod.email:
        return 'email';
    }
  }
}

class OtpMethodDialog extends StatelessWidget {
  final OtpMethod? initialMethod;

  const OtpMethodDialog({Key? key, this.initialMethod}) : super(key: key);

  static Future<OtpMethod?> show(BuildContext context, {OtpMethod? initial}) async {
    return showDialog<OtpMethod>(
      context: context,
      builder: (context) => OtpMethodDialog(initialMethod: initial),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppTheme.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.chooseVerificationMethod, // الترجمة
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          MyCustomButton(
            text: l10n.sms, // ترجمة SMS
            color: AppTheme.primary,
            borderColor: AppTheme.primary,
            textColor: Colors.white,
            width: double.infinity,
            height: 50.h,
            radius: 10.r,
            voidCallback: () {
              Navigator.pop(context, OtpMethod.sms);
            },
          ),
          SizedBox(height: 10.h),
          MyCustomButton(
            text: l10n.email, // ترجمة Email
            color: Colors.grey,
            borderColor: Colors.grey,
            textColor: Colors.black,
            width: double.infinity,
            height: 50.h,
            radius: 10.r,
            voidCallback: () {
              Navigator.pop(context, OtpMethod.email);
            },
          ),
          SizedBox(height: 15.h),
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(
              l10n.cancel, // ترجمة إلغاء
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
