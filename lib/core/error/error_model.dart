class ErrorModel {
  final String status;
  final int code;
  final String message;

  ErrorModel({this.status = "error", this.code = 0, required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status'] ?? "error",
      code: json['code'] ?? 0,
      message: json['message'] ?? "Unknown error",
    );
  }
}
