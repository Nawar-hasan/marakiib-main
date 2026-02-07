class UserRegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final String drivingLicenseImage;
  final String role;
  final String otpMethod;

  UserRegisterModel({
    required this.name,
    required this.otpMethod,

    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.drivingLicenseImage,
    this.role = "customer",
  });
}
