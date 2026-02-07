class CommissionModel {
  final int id;
  final String plateType;
  final String type;
  final String value;
  final String appliesTo;
  final String descriptionAr;
  final String descriptionEn;

  CommissionModel({
    required this.id,
    required this.plateType,
    required this.type,
    required this.value,
    required this.appliesTo,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      id: json['id'],
      plateType: json['plate_type'],
      type: json['type'],
      value: json['value'],
      appliesTo: json['applies_to'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
    );
  }
}
