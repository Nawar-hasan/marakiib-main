class RentalOfficeRegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phoneNumber;
  final String address;
  final double latitude;
  final String otpMethod;

  final double longitude;

  final String carLicenseImage;
  final String carLicenseExpiryDate;
  final String commercialRegistrationNumber;

  final String role;

  RentalOfficeRegisterModel({
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
    required this.commercialRegistrationNumber,
    this.role = "rental_office",
  });
}
