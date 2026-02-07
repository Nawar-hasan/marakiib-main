class PopularCarsResponse {
  final List<PopularCarModel> data;

  PopularCarsResponse({required this.data});

  factory PopularCarsResponse.fromJson(Map<String, dynamic> json) {
    return PopularCarsResponse(
      data:
          (json['data'] as List)
              .map((e) => PopularCarModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList()};
  }
}

class PopularCarModel {
  final int id;
  final String? name; // Changed to nullable
  final String? model; // Changed to nullable
  final String? color; // Changed to nullable
  final String? mainImage; // Changed to nullable
  final int carTypeId;
  final String? engineType; // Changed to nullable
  final String? slug; // Changed to nullable
  final String? rentalPrice; // Changed to nullable
  final String? plateType; // Added
  final String? availabilityStart; // Changed to nullable
  final String? availabilityEnd; // Changed to nullable
  final String? latitude; // Changed to nullable
  final String? longitude; // Changed to nullable
  final int longTermGuarantee;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;
  final int isActive;
  final String? insuranceType; // Changed to nullable
  final String? usageNature; // Changed to nullable
  final String? description; // Changed to nullable
  final String? metaTitle; // Changed to nullable
  final String? metaDescription; // Changed to nullable
  final String? imageAlt; // Changed to nullable
  final int bookingsCount;
  final List<Category> categories;
  final List<Feature> features;
  final List<Option> options;

  PopularCarModel({
    required this.id,
    this.name, // Changed to nullable
    this.model, // Changed to nullable
    this.color, // Changed to nullable
    this.mainImage, // Changed to nullable
    required this.carTypeId,
    this.engineType, // Changed to nullable
    this.slug, // Changed to nullable
    this.rentalPrice, // Changed to nullable
    this.plateType, // Added
    this.availabilityStart, // Changed to nullable
    this.availabilityEnd, // Changed to nullable
    this.latitude, // Changed to nullable
    this.longitude, // Changed to nullable
    required this.longTermGuarantee,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
    required this.isActive,
    this.insuranceType, // Changed to nullable
    this.usageNature, // Changed to nullable
    this.description, // Changed to nullable
    this.metaTitle, // Diversity
    this.metaDescription, // Changed to nullable
    this.imageAlt, // Changed to nullable
    required this.bookingsCount,
    required this.categories,
    required this.features,
    required this.options,
  });

  factory PopularCarModel.fromJson(Map<String, dynamic> json) {
    return PopularCarModel(
      id: json['id'] ?? 0, // Provide default value for int
      name: json['name'],
      model: json['model'],
      color: json['color'],
      mainImage: json['main_image'],
      carTypeId: json['car_type_id'] ?? 0,
      engineType: json['engine_type'],
      slug: json['slug'],
      rentalPrice: json['rental_price'],
      availabilityStart: json['availability_start'],
      availabilityEnd: json['availability_end'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      plateType: json['plate_type']?.toString(), // Added
      longTermGuarantee: json['long_term_guarantee'] ?? 0,
      pickupDelivery: json['pickup_delivery'] ?? 0,
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
      commissionValue: json['commission_value']?.toString(),
      commissionType: json['commission_type'],
      isActive: json['is_active'] ?? 0,
      insuranceType: json['insurance_type'],
      usageNature: json['usage_nature'],
      description: json['description'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      imageAlt: json['image_alt'],
      bookingsCount: json['bookings_count'] ?? 0,
      categories:
          (json['categories'] as List?)
              ?.map((e) => Category.fromJson(e))
              .toList() ??
          [],
      features:
          (json['features'] as List?)
              ?.map((e) => Feature.fromJson(e))
              .toList() ??
          [],
      options:
          (json['options'] as List?)?.map((e) => Option.fromJson(e)).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'color': color,
      'main_image': mainImage,
      'car_type_id': carTypeId,
      'engine_type': engineType,
      'slug': slug,
      'rental_price': rentalPrice,
      'availability_start': availabilityStart,
      'availability_end': availabilityEnd,
      'latitude': latitude,
      'longitude': longitude,
      'long_term_guarantee': longTermGuarantee,
      'pickup_delivery': pickupDelivery,
      'is_active': isActive,
      'insurance_type': insuranceType,
      'usage_nature': usageNature,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'image_alt': imageAlt,
      'bookings_count': bookingsCount,
      'categories': categories.map((e) => e.toJson()).toList(),
      'features': features.map((e) => e.toJson()).toList(),
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class Category {
  final int id;
  final String? name; // Changed to nullable
  final String? slug; // Changed to nullable
  final String? image; // Changed to nullable

  Category({
    required this.id,
    this.name, // Changed to nullable
    this.slug, // Changed to nullable
    this.image, // Changed to nullable
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug, 'image': image};
  }
}

class Feature {
  final int featureId;
  final String? featureName; // Changed to nullable
  final int valueId;
  final String? value; // Changed to nullable

  Feature({
    required this.featureId,
    this.featureName, // Changed to nullable
    required this.valueId,
    this.value, // Changed to nullable
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureId: json['feature_id'] ?? 0,
      featureName: json['feature_name'],
      valueId: json['value_id'] ?? 0,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feature_id': featureId,
      'feature_name': featureName,
      'value_id': valueId,
      'value': value,
    };
  }
}

class Option {
  final int id;
  final String? name; // Changed to nullable
  final String? slug; // Changed to nullable
  final String? price; // Changed to nullable

  Option({
    required this.id,
    this.name, // Changed to nullable
    this.slug, // Changed to nullable
    this.price, // Changed to nullable
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? 0,
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug, 'price': price};
  }
}
