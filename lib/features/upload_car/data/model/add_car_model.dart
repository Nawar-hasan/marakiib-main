import 'dart:io';

class CarModel {
  final Map<String, String> name;
  final String model;
  final String color;
  final File? mainImage;
  final List<File> extraImages;
  final String engineType;
  final String slug;
  final String plateType;
  final int rentalPrice;
  final String availabilityStart;
  final String availabilityEnd;
  final double latitude;
  final double longitude;
  final bool longTermGuarantee;
  final bool pickupDelivery;
  final int? pickupDeliveryPrice;
  final bool isActive;
  final Map<String, String> insuranceType;
  final Map<String, String> usageNature;
  final Map<String, String> description;
  final Map<String, String> metaTitle;
  final Map<String, String> metaDescription;
  final Map<String, String> imageAlt;
  final int carTypeId;
  final List<int> categoryIds;
  final List<int> featureValueIds;
  final List<int> optionIds;

  CarModel({
    required this.name,
    required this.model,
    required this.color,
    this.mainImage,
    required this.extraImages,
    required this.engineType,
    required this.slug,
    required this.plateType,
    required this.rentalPrice,
    required this.availabilityStart,
    required this.availabilityEnd,
    required this.latitude,
    required this.longitude,
    required this.longTermGuarantee,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    required this.isActive,
    required this.insuranceType,
    required this.usageNature,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.imageAlt,
    required this.carTypeId,
    required this.categoryIds,
    required this.featureValueIds,
    required this.optionIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'name[en]': name['en'],
      'name[ar]': name['ar'],
      'model': model,
      'color': color,
      'engine_type': engineType,
      'slug': slug,
      'plate_type': plateType,
      'rental_price': rentalPrice,
      'availability_start': availabilityStart,
      'availability_end': availabilityEnd,
      'latitude': latitude,
      'longitude': longitude,

      // ✅ Bool → Int (0 / 1)
      'long_term_guarantee': longTermGuarantee ? 1 : 0,
      'pickup_delivery': pickupDelivery ? 1 : 0,
      'pickup_delivery_price': pickupDeliveryPrice ?? 0,
      'is_active': isActive ? 1 : 0,

      'insurance_type[en]': insuranceType['en'],
      'insurance_type[ar]': insuranceType['ar'],
      'usage_nature[en]': usageNature['en'],
      'usage_nature[ar]': usageNature['ar'],
      'description[en]': description['en'],
      'description[ar]': description['ar'],
      'meta_title[en]': metaTitle['en'],
      'meta_title[ar]': metaTitle['ar'],
      'meta_description[en]': metaDescription['en'],
      'meta_description[ar]': metaDescription['ar'],
      'image_alt[en]': imageAlt['en'],
      'image_alt[ar]': imageAlt['ar'],
      'car_type_id': carTypeId,
      'category_ids[]': categoryIds,
      'feature_value_ids[]': featureValueIds,
      'option_ids[]': optionIds,
    };
  }
}
