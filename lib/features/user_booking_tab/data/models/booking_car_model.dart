class BookingUserModel {
  final int id;
  final String carName;
  final String? carModel;
  final String startDate;
  final String endDate;
  final String total;
  final String status;
  final String contactNumber;
  final String renterName;
  final bool isActive;
  final String slug;
  final String imageUrl;
  final String ownerName;
  final String? plateType;
  final List<Category> categories;
  final List<Feature> features;
  final String? basePrice;
  final String? commissionAmount;
  final int? pickupDelivery;
  final String? pickupDeliveryPrice;

  BookingUserModel({
    required this.id,
    required this.carName,
    this.carModel,
    required this.startDate,
    required this.endDate,
    required this.total,
    required this.status,
    required this.contactNumber,
    required this.renterName,
    required this.isActive,
    required this.slug,
    required this.imageUrl,
    required this.ownerName,
    this.plateType,
    required this.categories,
    required this.features,
    this.basePrice,
    this.commissionAmount,
    this.pickupDelivery,
    this.pickupDeliveryPrice,
  });

  factory BookingUserModel.fromJson(Map<String, dynamic> json) {
    var car = json['car'] ?? {};
    return BookingUserModel(
      id: json['id'],
      carName: json['car_name'] ?? '',
      carModel: json['car_model'],
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      total: json['total']?.toString() ?? '',
      status: json['status'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      renterName: json['renter_name'] ?? '',
      isActive: json['is_active'] ?? false,
      slug: json['slug'] ?? '',
      imageUrl: car['main_image'] ?? 'assets/images/car.png',
      ownerName: car['owner_name'] ?? '',
      plateType: car['plate_type'],
      categories:
          (car['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e))
              .toList() ??
          [],
      features:
          (car['features'] as List<dynamic>?)
              ?.map((e) => Feature.fromJson(e))
              .toList() ??
          [],
      basePrice: json['base_price']?.toString(),
      commissionAmount: json['commission_amount']?.toString(),
      pickupDelivery: json['pickup_delivery'],
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String? image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'],
    );
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
      featureId: json['feature_id'],
      featureName: json['feature_name'] ?? '',
      valueId: json['value_id'],
      value: json['value'] ?? '',
    );
  }
}
