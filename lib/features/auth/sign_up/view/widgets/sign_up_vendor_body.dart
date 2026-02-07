import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/sign_up_screen_body.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/sign_up_vendor_private_renter.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/sign_up_vendor_rental_office.dart';
import '../../../../../core/themeing/app_theme.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textFild.dart';

// Sample localization class (replace with your actual localization solution)
class AppLocalizations {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'signUpTitle': 'Create Account',
      'signUpDescription': 'Sign up now and enjoy rental ease like never before.',
      'privateRenter': 'Private Renter',
      'rentalOffice': 'Rental Office',
    },
    'ar': {
      'signUpTitle': 'إنشاء حساب',
      'signUpDescription': 'سجّل الآن وتمتع بسهولة التأجير كما لم يحدث من قبل.',
      'privateRenter': 'مؤجر خاص',
      'rentalOffice': 'مكتب تأجير',
    },
  };

  static String translate(String key, BuildContext context) {
    // Replace this with your actual locale detection logic
    String locale = Localizations.localeOf(context).languageCode;
    return _localizedValues[locale]?[key] ?? key;
  }
}

class SignUpVendorBody extends StatefulWidget {
  const SignUpVendorBody({super.key});

  @override
  State<SignUpVendorBody> createState() => _SignUpVendorBodyState();
}

class _SignUpVendorBodyState extends State<SignUpVendorBody> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.translate('signUpTitle', context),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppTheme.primary),
        ),
        SizedBox(height: 15.h),
        Center(
          child: Text(
            AppLocalizations.translate('signUpDescription', context),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.grey),
          ),
        ),
        Container(
          height: 44.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.gray111,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              _buildTabButton(0, AppLocalizations.translate('privateRenter', context)),
              _buildTabButton(1, AppLocalizations.translate('rentalOffice', context)),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: selectedIndex == 0
              ? SignUpVendorPrivateRenter()
              : SignUpVendorRentalOffice(),
        ),
      ],
    );
  }

  Widget _buildTabButton(int index, String text) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : AppTheme.gray111,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            text,
            style: GoogleFonts.ibmPlexSansArabic(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.white : AppTheme.black,
            ),
          ),
        ),
      ),
    );
  }
}
