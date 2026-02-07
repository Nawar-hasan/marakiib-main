import 'package:marakiib_app/features/vendor_financings/data/models/financing_plan_model.dart';

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
  final Map<String, dynamic>? car;
  final FinancingPlanModel? plan;

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
    this.car,
    this.plan,
  });

  factory FinancedCarModel.fromJson(Map<String, dynamic> json) {
    return FinancedCarModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      carId: json['car_id'] ?? 0,
      planId: json['plan_id'] ?? 0,
      days: json['days'] ?? 0,
      totalPrice: json['total_price']?.toString() ?? '0',
      startDate:
          json['start_date'] != null
              ? DateTime.parse(json['start_date'])
              : DateTime.now(),
      endDate:
          json['end_date'] != null
              ? DateTime.parse(json['end_date'])
              : DateTime.now(),
      status: json['status'] ?? 'active',
      car: json['car'] as Map<String, dynamic>?,
      plan:
          json['plan'] != null
              ? FinancingPlanModel.fromJson(json['plan'])
              : null,
    );
  }

  // Helper methods
  String get carName {
    if (car == null) return '';
    return car!['name'] ?? '';
  }

  String get carImage {
    if (car == null) return '';
    return car!['main_image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'car_id': carId,
      'plan_id': planId,
      'days': days,
      'total_price': totalPrice,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'car': car,
      'plan': plan?.toJson(),
    };
  }
}
