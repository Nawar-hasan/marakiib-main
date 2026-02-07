import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:marakiib_app/main.dart';
import '../themeing/app_theme.dart';
import '../widgets/custom_button.dart';

enum AppLanguage { en, ar }

class InternetConnectionWrapper extends StatefulWidget {
  final Widget child;
  final AppLanguage language;

  const InternetConnectionWrapper({
    super.key,
    required this.child,
    this.language = AppLanguage.en,
  });

  @override
  State<InternetConnectionWrapper> createState() => _InternetConnectionWrapperState();
}

class _InternetConnectionWrapperState extends State<InternetConnectionWrapper> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isDialogShowing = false;
  Timer? _periodicCheckTimer;

  @override
  void initState() {
    super.initState();
    debugPrint('InternetConnectionWrapper: initState called');
    // Delay initial check to ensure navigatorKey is initialized
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        debugPrint('Initial internet check triggered');
        checkInternetConnection();
      }
    });

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      debugPrint('Connectivity changed: $results');
      if (results.contains(ConnectivityResult.none)) {
        debugPrint('No network detected, attempting to show dialog');
        showNoInternetDialog();
      } else {
        debugPrint('Network available, checking actual internet');
        checkInternetConnection();
      }
    });

    _periodicCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      debugPrint('Periodic internet check');
      checkInternetConnection();
    });
  }

  @override
  void dispose() {
    debugPrint('InternetConnectionWrapper: dispose called');
    _connectivitySubscription?.cancel();
    _periodicCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> checkInternetConnection() async {
    try {
      var connectivityResults = await Connectivity().checkConnectivity();
      debugPrint('Connectivity check result: $connectivityResults');
      if (connectivityResults.contains(ConnectivityResult.none)) {
        debugPrint('No network, attempting to show dialog');
        showNoInternetDialog();
        return;
      }

      bool hasInternet = await _checkActualInternetConnection();
      debugPrint('Actual internet check: $hasInternet');
      if (!hasInternet) {
        debugPrint('No internet, attempting to show dialog');
        showNoInternetDialog();
      }
    } catch (e) {
      debugPrint('Error in checkInternetConnection: $e');
      showNoInternetDialog();
    }
  }

  Future<bool> _checkActualInternetConnection() async {
    try {
      final response = await http
          .get(Uri.parse('https://1.1.1.1'))
          .timeout(const Duration(seconds: 3));
      debugPrint('HTTP response code: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('HTTP check failed: $e');
      return false;
    }
  }

  void showNoInternetDialog() {
    if (_isDialogShowing) {
      debugPrint('Dialog already showing, skipping');
      return;
    }

    final navigatorContext = MyAppView.navigatorKey.currentContext;
    if (navigatorContext == null || !mounted) {
      debugPrint('Navigator context not available or widget not mounted, cannot show dialog');
      return;
    }

    _isDialogShowing = true;
    debugPrint('Showing no internet dialog');

    final String title = widget.language == AppLanguage.ar
        ? "لا يوجد اتصال بالإنترنت"
        : "No Internet Connection";
    final String message = widget.language == AppLanguage.ar
        ? "يرجى التحقق من الاتصال وحاول مرة أخرى."
        : "Please check your connection and try again.";
    final String retryText = widget.language == AppLanguage.ar ? "إعادة المحاولة" : "Retry";
    final String closeText = widget.language == AppLanguage.ar ? "إغلاق" : "Close";

    showDialog(
      context: navigatorContext,
      barrierDismissible: true,
      builder: (dialogContext) {
        debugPrint('Building dialog');
        return AlertDialog(
          backgroundColor: AppTheme.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 260,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/offline_dgaccel.json',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: $error');
                    return const Text('Image failed to load');
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.gray200,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Retry button pressed');
                        Navigator.of(dialogContext).pop();
                        GoRouter.of(navigatorContext).go('/SplashScreen');
                        _isDialogShowing = false;
                        checkInternetConnection();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.white,
                        minimumSize: const Size(120, 40),
                      ),
                      child: Text(retryText),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Close button pressed');
                        _isDialogShowing = false;
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else {
                          Navigator.of(dialogContext).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.white,
                        foregroundColor: AppTheme.black,
                        side: BorderSide(color: AppTheme.primary),
                        minimumSize: const Size(120, 40),
                      ),
                      child: Text(closeText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _isDialogShowing = false;
      debugPrint('Dialog dismissed');
    }).catchError((e) { 
      _isDialogShowing = false;
      debugPrint('Error showing dialog: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('InternetConnectionWrapper: build called');
    return widget.child;
  }
}
