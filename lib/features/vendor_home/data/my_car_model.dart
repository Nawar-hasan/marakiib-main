import 'package:flutter/material.dart';

class VendorCarModel {
  final int id;
  final String? nameEn;
  final String? nameAr;
  final String? model;
  final String? color;
  final String? engineType;
  final String? plateType;
  final double? rentalPrice;
  final String? image;
  final String? fuelType;
  final String? transmission;
  final int? capacity;
  final List<String>? extraImages;
  final String? availabilityStart;
  final String? availabilityEnd;
  final String? latitude;
  final String? longitude;
  final bool longTermGuarantee; // ✅ bool
  final bool pickupDelivery; // ✅ bool
  final int? pickupDeliveryPrice;
  final bool isActive; // ✅ bool
  final String? insuranceType;
  final String? usageNature;
  final String? description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;
  final List<Map<String, dynamic>>? categories;

  VendorCarModel({
    required this.id,
    this.nameEn,
    this.nameAr,
    this.model,
    this.color,
    this.engineType,
    this.plateType,
    this.rentalPrice,
    this.image,
    this.fuelType,
    this.transmission,
    this.capacity,
    this.extraImages,
    this.availabilityStart,
    this.availabilityEnd,
    this.latitude,
    this.longitude,
    this.longTermGuarantee = false,
    this.pickupDelivery = false,
    this.pickupDeliveryPrice,
    this.isActive = false,
    this.insuranceType,
    this.usageNature,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
    this.categories,
  });

  factory VendorCarModel.fromJson(Map<String, dynamic> json) {
    final featureValues = (json['feature_values'] as List<dynamic>?) ?? [];

    String? getFeatureValue(int featureId, String locale) {
      final feature = featureValues.firstWhere(
        (fv) => fv['feature_id'] == featureId,
        orElse: () => null,
      );
      if (feature == null) return null;
      final translation = (feature['translations'] as List<dynamic>?)
          ?.firstWhere((t) => t['locale'] == locale, orElse: () => null);
      return translation != null ? translation['value'] as String? : null;
    }

    return VendorCarModel(
      id: json['id'] ?? 0,
      nameEn:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['name']
              as String? ??
          json['name'] as String?,
      nameAr:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'ar',
                orElse: () => null,
              )?['name']
              as String?,
      model: json['model'] as String?,
      color: json['color'] as String?,
      engineType: json['engine_type'] as String?,
      plateType: json['plate_type'] as String?,
      rentalPrice:
          (json['rental_price'] != null)
              ? double.tryParse(json['rental_price'].toString())
              : null,
      image: json['main_image'] as String?,
      fuelType: getFeatureValue(3, 'en'),
      transmission: getFeatureValue(2, 'en'),
      capacity: int.tryParse(getFeatureValue(4, 'en') ?? '0'),
      extraImages: (json['extra_images'] as List<dynamic>?)?.cast<String>(),
      availabilityStart: json['availability_start'] as String?,
      availabilityEnd: json['availability_end'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      longTermGuarantee:
          (json['long_term_guarantee'] ?? 0) == 1, // ✅ تحويل من int لـ bool
      pickupDelivery: (json['pickup_delivery'] ?? 0) == 1, // ✅
      pickupDeliveryPrice:
          json['pickup_delivery_price'] != null
              ? int.tryParse(json['pickup_delivery_price'].toString())
              : null,
      isActive: (json['is_active'] ?? 0) == 1, // ✅
      insuranceType:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['insurance_type']
              as String?,
      usageNature:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['usage_nature']
              as String?,
      description:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['description']
              as String?,
      metaTitle:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['meta_title']
              as String?,
      metaDescription:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['meta_description']
              as String?,
      imageAlt:
          (json['translations'] as List<dynamic>?)?.firstWhere(
                (t) => t['locale'] == 'en',
                orElse: () => null,
              )?['image_alt']
              as String?,
      categories:
          (json['categories'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'model': model,
      'color': color,
      'engine_type': engineType,
      'plate_type': plateType,
      'rental_price': rentalPrice,
      'main_image': image,
      'fuel_type': fuelType,
      'transmission': transmission,
      'capacity': capacity,
      'extra_images': extraImages,
      'availability_start': availabilityStart,
      'availability_end': availabilityEnd,
      'latitude': latitude,
      'longitude': longitude,
      'long_term_guarantee': longTermGuarantee ? 1 : 0, // ✅ bool → int
      'pickup_delivery': pickupDelivery ? 1 : 0, // ✅
      'pickup_delivery_price': pickupDeliveryPrice,
      'is_active': isActive ? 1 : 0, // ✅
      'insurance_type': insuranceType,
      'usage_nature': usageNature,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'image_alt': imageAlt,
      'categories': categories,
    };
  }
}
