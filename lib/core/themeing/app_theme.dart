import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Color primary = Color(0xffC10003);
  static const Color secondaryPrimary = Color(0xffFFA726);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color gray = Color(0xffD8DADC);
  static const Color gray900 = Color(0xff111827);
  static const Color gray901 = Color(0xff262626);
  static const Color gray1 = Color(0xffF9FAFB);
  static const Color gray50 = Color(0xffF9FAFB);
  static const Color gray400 = Color(0xff9CA3B0);
  static const Color gray100 = Color(0xffF3F4F6);
  static const Color gray1010 = Color(0xffD7D7D7);
  static const Color gray1011 = Color(0xffEDEDED);
  static const Color gray111 = Color(0xffF9F9F9);

  static const Color gray200 = Color(0xff7F7F7F);
  static const Color blueLight = Color(0xffCBC9E2);
  static const Color blueLight2 = Color(0xffF5F6FF);
  static const Color tertiary = Color(0xffeeeeef);
  static const Color grayWhite = Color(0xffFAFAFA);
  static const Color gray2 = Color(0xff767676);
  static const Color green = Color(0xff069A2B);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,
    primaryColor: white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(fontSize: 5),
      unselectedLabelStyle: TextStyle(fontSize: 9),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: black,
        fontFamily: 'Montserrat',
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: black,
        fontFamily: 'Montserrat',
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: black,
        fontFamily: 'Montserrat',
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: black,
        fontFamily: 'Montserrat',
      ),
    ),
  );
}
