class PrivateRenterRegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final String otpMethod;


  final String carLicenseImage;
  final String carLicenseExpiryDate;

  final String role;

  PrivateRenterRegisterModel({
    required this.otpMethod,

    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.carLicenseImage,
    required this.carLicenseExpiryDate,
    this.role = "private_renter",
  });
}
