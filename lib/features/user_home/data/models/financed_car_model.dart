class FinancedCarModel {
  final int id;
  final int userId;
  final int carId;
  final int planId;
  final int days;
  final String totalPrice;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int viewsCount;
  final bool isActive;
  final CarModel? car; // ممكن null
  final PlanModel plan;
  final String? plateType;
  final int? pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? commissionValue;
  final String? commissionType;

  FinancedCarModel({
    required this.id,
    required this.userId,
    required this.carId,
    required this.planId,
    required this.days,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.viewsCount,
    required this.isActive,
    required this.car,
    required this.plan,
    this.plateType,
    this.pickupDelivery,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
  });

  factory FinancedCarModel.fromJson(Map<String, dynamic> json) {
    return FinancedCarModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      carId: json['car_id'] ?? 0,
      planId: json['plan_id'] ?? 0,
      days: json['days'] ?? 0,
      totalPrice: json['total_price'] ?? '0',
      startDate: DateTime.parse(
        json['start_date'] ?? DateTime.now().toString(),
      ),
      endDate: DateTime.parse(json['end_date'] ?? DateTime.now().toString()),
      status: json['status'] ?? 'unknown',
      viewsCount: json['views_count'] ?? 0,
      isActive: json['is_active'] ?? false,
      car: json['car'] != null ? CarModel.fromJson(json['car']) : null,
      plan: PlanModel.fromJson(json['plan']),
      plateType: json['plate_type']?.toString(),
      pickupDelivery: json['pickup_delivery'] as int?,
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
      commissionValue: json['commission_value']?.toString(),
      commissionType: json['commission_type'],
    );
  }
}

class CarModel {
  final int id;
  final String name;
  final String mainImage;
  final String rentalPrice;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final String? plateType;
  final String? commissionValue;
  final String? commissionType;

  CarModel({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.rentalPrice,
    required this.pickupDelivery,
    this.plateType,
    this.pickupDeliveryPrice,
    this.commissionValue,
    this.commissionType,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Car',
      mainImage: json['main_image'] ?? 'https://via.placeholder.com/150',
      rentalPrice: json['rental_price'] ?? '0',
      pickupDelivery: json['pickup_delivery'] ?? 0,
      plateType: json['plate_type']?.toString(),
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
      commissionValue: json['commission_value']?.toString(),
      commissionType: json['commission_type'],
    );
  }
}

class PlanModel {
  final int id;
  final String name;
  final String plateType;
  final String dailyPrice;

  PlanModel({
    required this.id,
    required this.name,
    required this.plateType,
    required this.dailyPrice,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      plateType: json['plate_type'] ?? '',
      dailyPrice: json['daily_price'] ?? '0',
    );
  }
}
