class CarsAvailableModel {
  final int id;
  final String name;
  final String model;
  final String color;
  final String mainImage;
  final int carTypeId;
  final String engineType;
  final String slug;
  final String? plateType;
  final String rentalPrice;
  final String availabilityStart;
  final String availabilityEnd;
  final String latitude;
  final String longitude;
  final int longTermGuarantee;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;
  final int isActive;
  final String insuranceType;
  final String usageNature;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final String imageAlt;
  final List<CategoryModel> categories;
  final List<FeatureModel> features;
  final List<OptionModel> options;

  CarsAvailableModel({
    required this.id,
    required this.name,
    required this.model,
    required this.color,
    required this.mainImage,
    required this.carTypeId,
    required this.engineType,
    required this.slug,
    this.plateType,
    required this.rentalPrice,
    required this.availabilityStart,
    required this.availabilityEnd,
    required this.latitude,
    required this.longitude,
    required this.longTermGuarantee,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
    required this.isActive,
    required this.insuranceType,
    required this.usageNature,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.imageAlt,
    required this.categories,
    required this.features,
    required this.options,
  });

  factory CarsAvailableModel.fromJson(Map<String, dynamic> json) {
    return CarsAvailableModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      mainImage: json['main_image'] ?? '',
      carTypeId: json['car_type_id'] ?? 0,
      engineType: json['engine_type'] ?? '',
      slug: json['slug'] ?? '',
      plateType: json['plate_type']?.toString(),
      rentalPrice: json['rental_price'] ?? '',
      availabilityStart: json['availability_start'] ?? '',
      availabilityEnd: json['availability_end'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      longTermGuarantee: json['long_term_guarantee'] ?? 0,
      pickupDelivery: json['pickup_delivery'] ?? 0,
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
      commissionValue: json['commission_value']?.toString(),
      commissionType: json['commission_type'],
      isActive: json['is_active'] ?? 0,
      insuranceType: json['insurance_type'] ?? '',
      usageNature: json['usage_nature'] ?? '',
      description: json['description'] ?? '',
      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      imageAlt: json['image_alt'] ?? '',
      categories:
          (json['categories'] as List? ?? [])
              .map((e) => CategoryModel.fromJson(e))
              .toList(),
      features:
          (json['features'] as List? ?? [])
              .map((e) => FeatureModel.fromJson(e))
              .toList(),
      options:
          (json['options'] as List? ?? [])
              .map((e) => OptionModel.fromJson(e))
              .toList(),
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class FeatureModel {
  final int featureId;
  final String featureName;
  final int valueId;
  final String value;

  FeatureModel({
    required this.featureId,
    required this.featureName,
    required this.valueId,
    required this.value,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      featureId: json['feature_id'] ?? 0,
      featureName: json['feature_name'] ?? '',
      valueId: json['value_id'] ?? 0,
      value: json['value'] ?? '',
    );
  }
}

class OptionModel {
  final int id;
  final String name;
  final String slug;
  final String price;

  OptionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      price: json['price'] ?? '',
    );
  }
}
