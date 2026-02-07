class SubscriptionPlan {
  final int id;
  final String planName;
  final int maxCars;
  final int duration;
  final String price;
  final String? description;

  SubscriptionPlan({
    required this.id,
    required this.planName,
    required this.maxCars,
    required this.duration,
    required this.price,
    this.description,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json["id"],
      planName: json["plan_name"],
      maxCars: json["max_cars"],
      duration: json["duration"],
      price: json["price"],
      description: json["description"],
    );
  }
}
