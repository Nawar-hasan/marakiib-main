class SupportModel {
  final bool success;
  final String message;

  SupportModel({required this.success, required this.message});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
