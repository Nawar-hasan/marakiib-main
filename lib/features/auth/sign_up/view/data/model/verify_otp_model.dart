class VerifyOtpModel {
  final String email;
  final String otp_code;

  VerifyOtpModel({
    required this.email,
    required this.otp_code,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "otp_code": otp_code,
    };
  }
}
