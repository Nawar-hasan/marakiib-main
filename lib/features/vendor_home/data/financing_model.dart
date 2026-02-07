class FinancingModel {
  final int carId;
  final int planId;
  final int days;

  FinancingModel({
    required this.carId,
    required this.planId,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      "car_id": carId,
      "plan_id": planId,
      "days": days,
    };
  }
}
