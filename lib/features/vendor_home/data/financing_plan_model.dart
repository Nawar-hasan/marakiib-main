class FinancingPlanModel {
  final int id;
  final String name;
  final String plateType;
  final String dailyPrice;
  final int minDays;
  final int maxDays;
  final String description;

  FinancingPlanModel({
    required this.id,
    required this.name,
    required this.plateType,
    required this.dailyPrice,
    required this.minDays,
    required this.maxDays,
    required this.description,
  });

  factory FinancingPlanModel.fromJson(Map<String, dynamic> json) {
    return FinancingPlanModel(
      id: json['id'],
      name: json['name'],
      plateType: json['plate_type'],
      dailyPrice: json['daily_price'],
      minDays: json['min_days'],
      maxDays: json['max_days'],
      description: json['description'],
    );
  }
}
