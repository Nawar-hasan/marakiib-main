class CarReviewModel {
  final int id;
  final int carId;
  final String carName;
  final int userId;
  final String customerName;
  final String? customerAvatar;
  final int rating;
  final String comment;
  final String createdAt;
  final int isActive;

  CarReviewModel({
    required this.id,
    required this.carId,
    required this.carName,
    required this.userId,
    required this.customerName,
    this.customerAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.isActive,
  });

  factory CarReviewModel.fromJson(Map<String, dynamic> json) {
    return CarReviewModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      carId: json['car_id'] ?? 0,
      carName: json['car_name']?.toString() ?? '',
      userId: json['user_id'] ?? 0,
      customerName: json['customer_name']?.toString() ?? '',
      customerAvatar: json['customer_avatar']?.toString(),
      rating: json['rating'] ?? 0,
      comment: json['comment']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      isActive: json['is_active'] ?? 0,
    );
  }
}
