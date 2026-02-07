class SearchResponse {
  final List<CarModel> cars;

  SearchResponse({required this.cars});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final carsJson = json['data'] as List<dynamic>? ?? [];
    final cars = carsJson
        .map(
          (carJson) => CarModel.fromJson(carJson as Map<String, dynamic>),
    )
        .toList();
    return SearchResponse(cars: cars);
  }

  Map<String, dynamic> toJson() {
    return {'data': cars.map((car) => car.toJson()).toList()};
  }
}

class CarModel {
  final int id;
  final int userId;
  final int carTypeId;
  final String? model;
  final String? color;
  final String? mainImage;
  final List<String> extraImages;
  final String? engineType;
  final String? slug;
  final String? plateType;
  final double rentalPrice;
  final DateTime availabilityStart;
  final DateTime availabilityEnd;
  final String? latitude;
  final String? longitude;
  final bool longTermGuarantee;
  final bool pickupDelivery;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? name;
  final String? insuranceType;
  final String? usageNature;
  final String? description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;
  final List<Translation> translations;

  CarModel({
    required this.id,
    required this.userId,
    required this.carTypeId,
    this.model,
    this.color,
    this.mainImage,
    required this.extraImages,
    this.engineType,
    this.slug,
    this.plateType,
    required this.rentalPrice,
    required this.availabilityStart,
    required this.availabilityEnd,
    this.latitude,
    this.longitude,
    required this.longTermGuarantee,
    required this.pickupDelivery,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.name,
    this.insuranceType,
    this.usageNature,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
    required this.translations,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    final translationsJson = (json['translations'] as List<dynamic>?) ?? [];

    return CarModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      carTypeId: int.tryParse(json['car_type_id']?.toString() ?? '0') ?? 0,
      model: json['model'] as String?,
      color: json['color'] as String?,
      mainImage: json['main_image'] as String?,
      extraImages:
      (json['extra_images'] as List<dynamic>?)?.cast<String>() ?? [],
      engineType: json['engine_type'] as String?,
      slug: json['slug'] as String?,
      plateType: json['plate_type'] as String?,
      rentalPrice: double.tryParse(json['rental_price']?.toString() ?? '0.0') ??
          0.0,
      availabilityStart: DateTime.tryParse(
          json['availability_start']?.toString() ??
              DateTime.now().toIso8601String()) ??
          DateTime.now(),
      availabilityEnd: DateTime.tryParse(
          json['availability_end']?.toString() ??
              DateTime.now().toIso8601String()) ??
          DateTime.now(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      longTermGuarantee: (int.tryParse(
          json['long_term_guarantee']?.toString() ?? '0') ??
          0) ==
          1,
      pickupDelivery:
      (int.tryParse(json['pickup_delivery']?.toString() ?? '0') ?? 0) == 1,
      isActive: (int.tryParse(json['is_active']?.toString() ?? '0') ?? 0) == 1,
      sortOrder: int.tryParse(json['sort_order']?.toString() ?? '0') ?? 0,
      createdAt: DateTime.tryParse(
          json['created_at']?.toString() ??
              DateTime.now().toIso8601String()) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
          json['updated_at']?.toString() ??
              DateTime.now().toIso8601String()) ??
          DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'].toString())
          : null,
      name: json['name'] as String?,
      insuranceType: json['insurance_type'] as String?,
      usageNature: json['usage_nature'] as String?,
      description: json['description'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      imageAlt: json['image_alt'] as String?,
      translations: translationsJson
          .map(
            (translationJson) =>
            Translation.fromJson(translationJson as Map<String, dynamic>),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'car_type_id': carTypeId,
      'model': model,
      'color': color,
      'main_image': mainImage,
      'extra_images': extraImages,
      'engine_type': engineType,
      'slug': slug,
      'plate_type': plateType,
      'rental_price': rentalPrice.toString(),
      'availability_start': availabilityStart.toIso8601String(),
      'availability_end': availabilityEnd.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'long_term_guarantee': longTermGuarantee ? 1 : 0,
      'pickup_delivery': pickupDelivery ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'name': name,
      'insurance_type': insuranceType,
      'usage_nature': usageNature,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'image_alt': imageAlt,
      'translations': translations.map((t) => t.toJson()).toList(),
    };
  }
}

class Translation {
  final int id;
  final int carId;
  final String locale;
  final String? name;
  final String? insuranceType;
  final String? usageNature;
  final String? description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;

  Translation({
    required this.id,
    required this.carId,
    required this.locale,
    this.name,
    this.insuranceType,
    this.usageNature,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      carId: int.tryParse(json['car_id']?.toString() ?? '0') ?? 0,
      locale: json['locale']?.toString() ?? 'en',
      name: json['name'] as String?,
      insuranceType: json['insurance_type'] as String?,
      usageNature: json['usage_nature'] as String?,
      description: json['description'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      imageAlt: json['image_alt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car_id': carId,
      'locale': locale,
      'name': name,
      'insurance_type': insuranceType,
      'usage_nature': usageNature,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'image_alt': imageAlt,
    };
  }
}
