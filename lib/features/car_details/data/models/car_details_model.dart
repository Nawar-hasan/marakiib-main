class CarDetailsModel {
  final int id;
  final String name;
  final String? model;
  final String? color;
  final String mainImage;
  final List<String> extraImages;
  final int? carTypeId;
  final String? engineType;
  final String slug;
  final String rentalPrice;
  final String availabilityStart;
  final String availabilityEnd;
  final String latitude;
  final String longitude;
  final int longTermGuarantee;
  final int pickupDelivery;
  final String? pickupDeliveryPrice;
  final bool isActive;
  final String insuranceType;
  final String usageNature;
  final String description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;
  final String? plateType;
  final String? commissionValue;
  final String? commissionType;
  final List<CategoryModel> categories;
  final List<FeatureModel> features;
  final List<OptionModel> options;
  final UserModel user;
  final List<ReviewModel> reviews;
  final bool isFavourite;
  final bool isOffice;

  CarDetailsModel({
    required this.id,
    required this.name,
    this.model,
    this.color,
    required this.mainImage,
    required this.extraImages,
    this.carTypeId,
    this.engineType,
    required this.slug,
    required this.rentalPrice,
    required this.availabilityStart,
    required this.availabilityEnd,
    required this.latitude,
    required this.longitude,
    required this.longTermGuarantee,
    required this.pickupDelivery,
    this.pickupDeliveryPrice,
    required this.isActive,
    required this.insuranceType,
    required this.usageNature,
    required this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
    this.plateType, // ✅ تمت الإضافة هنا
    this.commissionValue,
    this.commissionType,
    required this.categories,
    required this.features,
    required this.options,
    required this.user,
    required this.reviews,
    this.isFavourite = false,
    this.isOffice = false,
  });

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return CarDetailsModel(
      id: data['id'],
      name: data['name'] ?? '',
      model: data['model'],
      color: data['color'],
      mainImage: data['main_image'] ?? '',
      extraImages:
          (data['extra_images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      carTypeId: data['car_type_id'],
      engineType: data['engine_type'],
      slug: data['slug'] ?? '',
      rentalPrice: data['rental_price'] ?? '0',
      availabilityStart: data['availability_start'] ?? '',
      availabilityEnd: data['availability_end'] ?? '',
      latitude: data['latitude'] ?? '',
      longitude: data['longitude'] ?? '',
      longTermGuarantee: data['long_term_guarantee'] ?? 0,
      pickupDelivery: data['pickup_delivery'] ?? 0,
      pickupDeliveryPrice: data['pickup_delivery_price']?.toString(),
      isActive: (data['is_active'] ?? 0) == 1,
      insuranceType: data['insurance_type'] ?? '',
      usageNature: data['usage_nature'] ?? '',
      description: data['description'] ?? '',
      metaTitle: data['meta_title'],
      metaDescription: data['meta_description'],
      imageAlt: data['image_alt'],
      plateType: data['plate_type'], // ✅ تمت الإضافة هنا
      commissionValue: data['commission_value']?.toString(),
      commissionType: data['commission_type'],
      categories:
          (data['categories'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [],
      features:
          (data['features'] as List<dynamic>?)
              ?.map((e) => FeatureModel.fromJson(e))
              .toList() ??
          [],
      options:
          (data['options'] as List<dynamic>?)
              ?.map((e) => OptionModel.fromJson(e))
              .toList() ??
          [],
      user: UserModel.fromJson(data['user']),
      reviews:
          (data['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
      isFavourite: data['is_favourite'] ?? false,
      isOffice: data['is_office'] ?? false,
    );
  }
}

// ✅ باقي الموديلات زي ما هي بس خلّي أي حاجة ممكن ترجع null تبقى String? أو int?

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      imageAlt: json['image_alt'],
    );
  }
}

class FeatureModel {
  final int featureId;
  final String featureName;
  final int valueId;
  final String value;
  final String? image;

  FeatureModel({
    required this.featureId,
    required this.featureName,
    required this.valueId,
    required this.value,
    this.image,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      featureId: json['feature_id'],
      featureName: json['feature_name'] ?? '',
      valueId: json['value_id'],
      value: json['value'] ?? '',
      image: json['image'],
    );
  }
}

class OptionModel {
  final int id;
  final String name;
  final String slug;
  final String price;

  OptionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      price: json['price'] ?? '0',
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      address: json['address'],
      avatar: json['avatar'],
    );
  }
}

class ReviewModel {
  final int id;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final SimpleUser user;

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      user: SimpleUser.fromJson(json['user']),
    );
  }
}

class SimpleUser {
  final int id;
  final String name;
  final String? avatar;

  SimpleUser({required this.id, required this.name, this.avatar});

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['id'],
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }
}
