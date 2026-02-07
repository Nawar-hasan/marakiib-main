import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/location_helper.dart';
import '../../../../core/network/end_point.dart';
import '../../../../core/routing/app_router.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLocation();
    });
  }

  /// 🔥 دالة فحص الاشتراك
  Future<bool> checkSubscriptionStatus(String token) async {
    try {
      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio
          .get('${EndPoints.baseUrl}${EndPoints.subscriptionsStatus}');

      return response.data["has_active_subscription"] == true;
    } catch (e) {
      print("❌ Subscription check error: $e");
      return false;
    }
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showGpsDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showPermissionDialog();
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showPermissionDialog();
        return;
      }

      final position = await LocationHelper.getCurrentLocation(context);
      if (position == null) return;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = '';
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }

      await prefs.setString("user_address", address);
      await prefs.setDouble("user_lat", position.latitude);
      await prefs.setDouble("user_lng", position.longitude);

      if (mounted) {
        Future.delayed(const Duration(seconds: 1), () async {
          final token = prefs.getString("token");
          final role = prefs.getString("role");
          final onBoardDone = prefs.getBool("onBoarding_completed") ?? false;

          if (token != null && role != null) {
            if (role == "customer") {
              context.go(AppRoutes.userNavBar);
            }
            //
            else if (role == "rental_office") {
              context.go(AppRoutes.VendorNavBarView);
            }
            //
            else if (role == "private_renter") {
              // ✔ لازم اشتراك
              final hasSubscription = await checkSubscriptionStatus(token);

              if (hasSubscription) {
                context.go(AppRoutes.VendorNavBarView);
              } else {
                context.go('/NotSub');
              }
            }
            //
            else {
              context.go('/OnBoardViewBody');
            }
          } else {
            if (onBoardDone) {
              context.go('/LoginScreen');
            } else {
              context.go('/OnBoardViewBody');
            }
          }
        });
      }
    } catch (e) {
      print("❌ Error while getting location: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ حصل خطأ: $e")),
        );
      }
    }
  }

  void _showGpsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("⚠️ الموقع مقفول"),
        content: const Text("من فضلك افتح خدمة الموقع GPS."),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openLocationSettings();
              Navigator.pop(context);
              _initLocation();
            },
            child: const Text("فتح الإعدادات"),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("❌ إذن الموقع مرفوض"),
        content: const Text("من فضلك وافق على إذن الموقع."),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
              Navigator.pop(context);
              _initLocation();
            },
            child: const Text("فتح الإعدادات"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              'assets/images/20b0287e1e347c796c0004343a293fdd9752f22a.png',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.h),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: CustomPaint(
                  painter: GradientCircularPainter(),
                  child: SizedBox(width: 48.w, height: 48.w),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GradientCircularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [Color(0xFFC10003), Color(0xFFFFFFFF)],
        startAngle: 0.0,
        endAngle: 2 * pi,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
