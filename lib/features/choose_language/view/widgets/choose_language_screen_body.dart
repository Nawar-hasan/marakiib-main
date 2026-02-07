import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/choose_language/view/widgets/search_bar.dart';

import 'choose_language_flag.dart';

class ChooseLanguageScreenBody extends StatelessWidget {
  const ChooseLanguageScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_rounded, color: AppTheme.black),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose the language',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppTheme.primary),
            ),
            SizedBox(height: 15.h),

            Center(
              child: Text(
                'Don’t worry! It happens. Please enter the email associated with your account.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
              ),
            ),
            SizedBox(height: 25.h),

            // SearchField(),
            SizedBox(height: 25.h),

            Expanded(child: LanguageSelector()),
          ],
        ),
      ),
    );
  }
}
