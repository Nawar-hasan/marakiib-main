class SubscriptionPlanModel {
  final int id;
  final String planName;
  final int maxCars;
  final int duration;
  final String price;

  SubscriptionPlanModel({
    required this.id,
    required this.planName,
    required this.maxCars,
    required this.duration,
    required this.price,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] ?? 0,
      planName: json['plan_name'] ?? '',
      maxCars: json['max_cars'] ?? 0,
      duration: json['duration'] ?? 0,
      price: json['price']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_name': planName,
      'max_cars': maxCars,
      'duration': duration,
      'price': price,
    };
  }
}
