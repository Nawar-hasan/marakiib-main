import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String provider;
  final String role;

  const SocialLoginButton({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.provider,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleSocialLogin(context),
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Center(
          child: FaIcon(iconData, color: iconColor, size: 24.sp),
        ),
      ),
    );
  }

  void _handleSocialLogin(BuildContext context) {
    if (provider == 'google') {
      // 🔸 Google → Deep Link (external browser)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GoogleDeepLinkHandler(role: role),
        ),
      );
    } else {
      // 🔹 Facebook → WebView
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SocialLoginWebView(provider: provider, role: role),
        ),
      );
    }
  }
}

class SocialLoginWebView extends StatefulWidget {
  final String provider;
  final String role;

  const SocialLoginWebView({
    super.key,
    required this.provider,
    required this.role,
  });

  @override
  State<SocialLoginWebView> createState() => _SocialLoginWebViewState();
}

class _SocialLoginWebViewState extends State<SocialLoginWebView> {
  late WebViewController _controller;
  bool _isLoading = true;

  final String baseUrl = 'https://api.marakiib.com/api';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => print('➡️ Page started loading: $url'),
          onPageFinished: (url) => setState(() => _isLoading = false),
          onNavigationRequest: (req) async {
            print('🚦 Navigation request: ${req.url}');
            if (req.url.contains('$baseUrl/auth/${widget.provider}/callback')) {
              await _handleCallback(req.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            '$baseUrl/auth/${widget.provider}/redirect?role=${widget.role}&locale=ar'),
      );
  }

  Future<void> _handleCallback(String url) async {
    try {
      final dio = Dio(BaseOptions(followRedirects: true, validateStatus: (s) => true));
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['user'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          await prefs.setString('role', data['user']['role']);
          await prefs.setInt('user_id', data['user']['id']);

          final requiresProfileCompletion =
              data['requires_profile_completion'] ?? true;

          if (requiresProfileCompletion == false) {
            if (mounted) context.pushReplacement(AppRoutes.completeProfileView);
            return;
          }

          final role = data['user']['role'];
          if (role == "customer") {
            if (mounted) context.pushReplacement(AppRoutes.userNavBar);
          } else if (role == "rental_office" || role == "private_renter") {
            if (mounted) context.pushReplacement(AppRoutes.VendorNavBarView);
          } else {
            if (mounted) context.pushReplacement('/OnBoardViewBody');
          }
        } else {
          _showError('⚠️ استجابة غير متوقعة من السيرفر');
        }
      } else {
        _showError('⚠️ فشل الاتصال بالسيرفر');
      }
    } catch (e) {
      _showError('حدث خطأ أثناء تسجيل الدخول');
      print('🔥 Error: $e');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with ${widget.provider.capitalize()}')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class GoogleDeepLinkHandler extends StatefulWidget {
  final String role;
  const GoogleDeepLinkHandler({super.key, required this.role});

  @override
  State<GoogleDeepLinkHandler> createState() => _GoogleDeepLinkHandlerState();
}

class _GoogleDeepLinkHandlerState extends State<GoogleDeepLinkHandler> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _listenForDeepLink();
    _launchGoogleLogin();
  }

  void _listenForDeepLink() async {
    // 🔹 تحقق من الرابط الأولي عند فتح التطبيق
    final initialUri = await _appLinks.getInitialLink();
    print("🔹 Initial deep link: $initialUri");
    if (initialUri != null) _handleDeepLink(initialUri);

    // 🔹 الاستماع للروابط الواردة
    _appLinks.uriLinkStream.listen(
          (uri) {
        print("🔹 Stream deep link received: $uri");
        if (uri != null) _handleDeepLink(uri);
      },
      onError: (err) => print("⚠️ Deep link stream error: $err"),
    );
  }

  void _handleDeepLink(Uri uri) async {
    print("🔹 Handling deep link: $uri");

    // مثال: myapp://auth/callback?token=xxx&role=private_renter&user_id=8
    if (uri.host == 'auth' && uri.path == '/callback') {
      final token = uri.queryParameters['token'];
      final role = uri.queryParameters['role'];
      final userId = uri.queryParameters['user_id'];

      print("🔹 Parsed deep link params -> token: $token, role: $role, user_id: $userId");

      if (token != null && role != null && userId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setInt('user_id', int.parse(userId));

        if (!mounted) return;

        if (role == 'customer') {
          print("🔹 Navigating to userNavBar");
          context.pushReplacement(AppRoutes.userNavBar);
        } else {
          print("🔹 Navigating to VendorNavBarView");
          context.pushReplacement(AppRoutes.VendorNavBarView);
        }
      }
    } else {
      print("⚠️ Deep link does not match expected scheme/path");
    }
  }

  Future<void> _launchGoogleLogin() async {
    final url = Uri.parse(
      'https://api.marakiib.com/api/auth/google/redirect?role=${widget.role}&locale=en&source=app',
    );
    print("🔹 Launching Google login URL: $url");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('⚠️ Could not launch Google login URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}



extension CapExtension on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
}
