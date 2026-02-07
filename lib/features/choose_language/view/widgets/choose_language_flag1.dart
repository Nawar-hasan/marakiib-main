import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themeing/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/localization/localization_bloc.dart';
import '../../../../core/localization/language_state.dart';

class Language {
  final String code;
  final String name;
  final String flagAsset;
  final String flagEmoji;

  Language({
    required this.code,
    required this.name,
    required this.flagAsset,
    required this.flagEmoji,
  });
}

class LanguageSelector1 extends StatelessWidget {
  LanguageSelector1({super.key});

  final List<Language> languages = [
    Language(
      code: 'ar',
      name: 'العربية',
      flagAsset: 'assets/flags/ar.png',
      flagEmoji: '🇸🇦',
    ),
    Language(
      code: 'en',
      name: 'English',
      flagAsset: 'assets/flags/en.png',
      flagEmoji: '🇬🇧',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        String selectedLanguage = state.languageCode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: languages.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected = selectedLanguage == language.code;

                  return LanguageItem(
                    language: language,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage(
                        language.code,
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),

            // MyCustomButton(
            //   text: selectedLanguage == 'ar' ? 'استمرار' : 'Continue',
            //   width: double.infinity,
            //   height: 52.h,
            //   radius: 12.r,
            //   fontSize: 16.sp,
            //   color: AppTheme.black,
            //   textColor: AppTheme.white,
            //   borderColor: AppTheme.black,
            //   voidCallback: () {
            //     context.push('/LoginScreen');
            //   },
            // ),
          ],
        );
      },
    );
  }
}

class LanguageItem extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItem({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gray1 : AppTheme.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppTheme.gray : Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Center(
                child: Text(
                  language.flagEmoji,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Text(
                language.name,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.black,
                ),
              ),
            ),

            if (isSelected)
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: AppTheme.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: AppTheme.white, size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }
}
