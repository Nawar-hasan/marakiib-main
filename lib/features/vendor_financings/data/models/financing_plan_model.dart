class FinancingPlanModel {
  final int id;
  final String name;
  final String dailyPrice;
  final int minDays;
  final int maxDays;
  final String? description;

  FinancingPlanModel({
    required this.id,
    required this.name,
    required this.dailyPrice,
    required this.minDays,
    required this.maxDays,
    this.description,
  });

  factory FinancingPlanModel.fromJson(Map<String, dynamic> json) {
    return FinancingPlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      dailyPrice: json['daily_price']?.toString() ?? '0',
      minDays: json['min_days'] ?? 0,
      maxDays: json['max_days'] ?? 0,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'daily_price': dailyPrice,
      'min_days': minDays,
      'max_days': maxDays,
      'description': description,
    };
  }
}
