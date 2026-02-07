import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/features/messages/view/widgets/searche_field.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: LatLng(0, 0), initialZoom: 1.5),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
            ],
          ),

          Positioned(
            top: 10.h,
            left: 16.w,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: CustomIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => context.pop(),
                ),
              ),
            ),
          ),

          Positioned(
            top: 115.h,
            left: 16.w,
            right: 16.w,
            child: CustomSearchField(),
          ),
        ],
      ),
    );
  }
}
