import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CarMapGoogle extends StatefulWidget {
  final double userLat;
  final double userLng;
  final double ownerLat;
  final double ownerLng;

  const CarMapGoogle({
    super.key,
    required this.userLat,
    required this.userLng,
    required this.ownerLat,
    required this.ownerLng,
  });

  @override
  State<CarMapGoogle> createState() => _CarMapGoogleState();
}

class _CarMapGoogleState extends State<CarMapGoogle> {
  late LatLng userLocation;
  late LatLng ownerLocation;
  late double distance;
  late GoogleMapController mapController;

  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371;

    double lat1Rad = point1.latitude * (math.pi / 180);
    double lat2Rad = point2.latitude * (math.pi / 180);
    double deltaLatRad = (point2.latitude - point1.latitude) * (math.pi / 180);
    double deltaLngRad = (point2.longitude - point1.longitude) * (math.pi / 180);

    double a = math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLngRad / 2) *
            math.sin(deltaLngRad / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  @override
  void initState() {
    super.initState();
    userLocation = LatLng(widget.userLat, widget.userLng);
    ownerLocation = LatLng(widget.ownerLat, widget.ownerLng);
    distance = _calculateDistance(userLocation, ownerLocation);
  }

  void _zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  (widget.userLat + widget.ownerLat) / 2,
                  (widget.userLng + widget.ownerLng) / 2,
                ),
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("user"),
                  position: userLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(title: translate.yourLocation),
                ),
                Marker(
                  markerId: const MarkerId("owner"),
                  position: ownerLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(title: translate.car),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: [userLocation, ownerLocation],
                  color: Colors.blue,
                  width: 4,
                ),
              },
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),

            // ✅ المسافة
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.straighten,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      translate.distanceKm(distance.toStringAsFixed(1)),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ✅ أزرار الزوم
            Positioned(
              bottom: 12,
              right: 12,
              child: Column(
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: _zoomIn,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: _zoomOut,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
