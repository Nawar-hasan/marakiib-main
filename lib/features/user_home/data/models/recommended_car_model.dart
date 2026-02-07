class RecommendedCarsResponse {
  final List<RecommendedCarModel> cars;

  RecommendedCarsResponse({required this.cars});

  factory RecommendedCarsResponse.fromJson(Map<String, dynamic> json) {
    final carsJson = json['data'] as List<dynamic>? ?? [];
    final cars =
        carsJson
            .map(
              (carJson) =>
                  RecommendedCarModel.fromJson(carJson as Map<String, dynamic>),
            )
            .toList();
    return RecommendedCarsResponse(cars: cars);
  }

  Map<String, dynamic> toJson() {
    return {'data': cars.map((car) => car.toJson()).toList()};
  }
}

class RecommendedCarModel {
  final int id;
  final String? name;
  final String? model;
  final String? color;
  final String mainImage;
  final String slug;
  final double rentalPrice;
  final String? plateType;
  final DateTime? availabilityStart;
  final DateTime? availabilityEnd;
  final bool isActive;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;
  final List<Category> categories;
  final List<Feature> features;

  RecommendedCarModel({
    required this.id,
    this.name,
    this.model,
    this.color,
    required this.mainImage,
    required this.slug,
    required this.rentalPrice,
    this.plateType,
    this.availabilityStart,
    this.availabilityEnd,
    required this.isActive,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
    required this.categories,
    required this.features,
  });

  factory RecommendedCarModel.fromJson(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as List<dynamic>? ?? [];
    final featuresJson = json['features'] as List<dynamic>? ?? [];

    return RecommendedCarModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString(),
      model: json['model']?.toString(),
      color: json['color']?.toString(),
      mainImage: json['main_image']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      rentalPrice:
          double.tryParse(json['rental_price']?.toString() ?? '0') ?? 0,
      plateType: json['plate_type']?.toString(),
      availabilityStart:
          json['availability_start'] != null
              ? DateTime.tryParse(json['availability_start'])
              : null,
      availabilityEnd:
          json['availability_end'] != null
              ? DateTime.tryParse(json['availability_end'])
              : null,
      isActive: (json['is_active'] ?? 0) == 1,
      pickupDelivery: json['pickup_delivery'] ?? 0,
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
      commissionValue: json['commission_value']?.toString(),
      commissionType: json['commission_type'],
      categories:
          categoriesJson
              .map((c) => Category.fromJson(c as Map<String, dynamic>))
              .toList(),
      features:
          featuresJson
              .map((f) => Feature.fromJson(f as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'color': color,
      'main_image': mainImage,
      'slug': slug,
      'rental_price': rentalPrice.toString(),
      'availability_start': availabilityStart?.toIso8601String(),
      'availability_end': availabilityEnd?.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'categories': categories.map((c) => c.toJson()).toList(),
      'features': features.map((f) => f.toJson()).toList(),
    };
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug, 'image': image};
  }
}

class Feature {
  final int featureId;
  final String featureName;
  final int valueId;
  final String value;

  Feature({
    required this.featureId,
    required this.featureName,
    required this.valueId,
    required this.value,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureId: json['feature_id'] ?? 0,
      featureName: json['feature_name']?.toString() ?? '',
      valueId: json['value_id'] ?? 0,
      value: json['value']?.toString() ?? '',
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
