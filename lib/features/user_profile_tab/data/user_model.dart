class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? phoneNumber;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String role;
  final String? drivingLicenseImage;
  final String? carLicenseImage;
  final DateTime? carLicenseExpiryDate;
  final String? commercialRegistrationNumber;
  final String? provider;
  final String? providerId;
  final String status;
  final String slug;
  final String? image;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? emailVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phoneNumber,
    this.address,
    this.latitude,
    this.longitude,
    required this.role,
    this.drivingLicenseImage,
    this.carLicenseImage,
    this.carLicenseExpiryDate,
    this.commercialRegistrationNumber,
    this.provider,
    this.providerId,
    required this.status,
    required this.slug,
    this.image,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatar: json["avatar"],
      phoneNumber: json["phone_number"],
      address: json["address"],
      latitude: json["latitude"] != null ? (json["latitude"] as num).toDouble() : null,
      longitude: json["longitude"] != null ? (json["longitude"] as num).toDouble() : null,
      role: json["role"],
      drivingLicenseImage: json["driving_license_image"],
      carLicenseImage: json["car_license_image"],
      carLicenseExpiryDate: json["car_license_expiry_date"] != null
          ? DateTime.tryParse(json["car_license_expiry_date"])
          : null,
      commercialRegistrationNumber: json["commercial_registration_number"],
      provider: json["provider"],
      providerId: json["provider_id"]?.toString(),
      status: json["status"],
      slug: json["slug"],
      image: json["image"],
      isActive: json["is_active"] ?? false,
      sortOrder: json["sort_order"] ?? 0,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"] != null ? DateTime.tryParse(json["deleted_at"]) : null,
      emailVerifiedAt: json["email_verified_at"] != null ? DateTime.tryParse(json["email_verified_at"]) : null,
    );
  }
}
