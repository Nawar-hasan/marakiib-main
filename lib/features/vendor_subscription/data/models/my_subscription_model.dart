import 'package:marakiib_app/features/vendor_subscription/data/models/subscription_plan_model.dart';

class MySubscriptionModel {
  final int id;
  final int userId;
  final int subscriptionPlanId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int carsCount;
  final SubscriptionPlanModel? plan;

  MySubscriptionModel({
    required this.id,
    required this.userId,
    required this.subscriptionPlanId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.carsCount,
    this.plan,
  });

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MySubscriptionModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      subscriptionPlanId: json['subscription_plan_id'] ?? 0,
      startDate:
          json['start_date'] != null
              ? DateTime.parse(json['start_date'])
              : DateTime.now(),
      endDate:
          json['end_date'] != null
              ? DateTime.parse(json['end_date'])
              : DateTime.now(),
      status: json['status'] ?? 'active',
      carsCount: json['cars_count'] ?? 0,
      plan:
          json['plan'] != null
              ? SubscriptionPlanModel.fromJson(json['plan'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'subscription_plan_id': subscriptionPlanId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'cars_count': carsCount,
      'plan': plan?.toJson(),
    };
  }
}
