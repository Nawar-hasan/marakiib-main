class BookingModel {
  final int id;
  final int carId;
  final String carName;
  final String carModel;
  final String startDate;
  final String endDate;
  final String total;
  final String status;
  final String contactNumber;
  final String slug;
  final String imageUrl;
  final bool isActive;
  final String renterName;
  final String? basePrice;
  final String? commissionAmount;
  final int? pickupDelivery;
  final String? pickupDeliveryPrice;

  BookingModel({
    required this.id,
    required this.carId,
    required this.carName,
    required this.carModel,
    required this.startDate,
    required this.endDate,
    required this.total,
    required this.status,
    required this.contactNumber,
    required this.slug,
    required this.imageUrl,
    required this.isActive,
    required this.renterName,
    this.basePrice,
    this.commissionAmount,
    this.pickupDelivery,
    this.pickupDeliveryPrice,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,
      carId: json['car_id'] ?? 0,
      carName: json['car_name']?.toString() ?? '',
      carModel: json['car_model']?.toString() ?? '',
      startDate: json['start_date']?.toString() ?? '',
      endDate: json['end_date']?.toString() ?? '',
      total: json['total']?.toString() ?? '0',
      status: json['status']?.toString() ?? '',
      contactNumber: json['contact_number']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      imageUrl:
          json['car']?['main_image']?.toString() ?? 'assets/images/car.png',
      isActive: json['is_active'] ?? false,
      renterName: json['renter_name']?.toString() ?? '',
      basePrice: json['base_price']?.toString(),
      commissionAmount: json['commission_amount']?.toString(),
      pickupDelivery: json['pickup_delivery'],
      pickupDeliveryPrice: json['pickup_delivery_price']?.toString(),
    );
  }
}
