import 'dart:io';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/notification/flutter_local_notifications_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'core/cash/shared.dart';
import 'core/localization/language_state.dart';
import 'core/localization/localization_bloc.dart';
import 'core/routing/app_router.dart';
import 'core/themeing/app_theme.dart';
import 'core/network/internet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 تهيئة Meta App Events مبكراً جداً (أول شيء بعد WidgetsFlutterBinding)
  // هذا ضروري لاحتساب تحميلات App Install campaigns
  final facebookAppEvents = FacebookAppEvents();

  // إرسال حدث تفعيل التطبيق فوراً (مهم جداً للتحويلات)
  await facebookAppEvents.logEvent(
    name: 'fb_mobile_activate_app'
  );

  // تهيئة Firebase بعد Meta (يمكن أن تكون Firebase بعد Meta)
  await Firebase.initializeApp();

  tz.initializeTimeZones();
  await NotificationService.initialization();

  if (Platform.isAndroid) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  } else if (Platform.isIOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }

  // ✅ التقاط أي أخطاء عامة في التطبيق
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
  };

  // ✅ تهيئة الكاش
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageCubit(),
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 835),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(state.languageCode),
            );
          },
        );
      },
    );
  }
}
