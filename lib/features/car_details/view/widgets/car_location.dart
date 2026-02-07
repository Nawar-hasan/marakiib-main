import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CarLocationText extends StatefulWidget {
  final String latitude;
  final String longitude;

  const CarLocationText({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CarLocationText> createState() => _CarLocationTextState();
}

class _CarLocationTextState extends State<CarLocationText> {
  String _address = "جارِ تحميل العنوان...";

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      final lat = double.tryParse(widget.latitude) ?? 0.0;
      final lng = double.tryParse(widget.longitude) ?? 0.0;

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _address =
              "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          _address = "لم يتم العثور على عنوان";
        });
      }
    } catch (e) {
      setState(() {
        _address = "خطأ في جلب العنوان";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.red, size: 20),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            _address,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
