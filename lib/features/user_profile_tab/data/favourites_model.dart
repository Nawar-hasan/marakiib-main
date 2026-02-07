class FavouriteModel {
  int id;
  int carId;
  String carName;
  String carModel;
  String carColor;
  String carImage;
  String rentalPrice;
  bool isActive;
  DateTime? createdAt;
  Car car;

  FavouriteModel({
    required this.id,
    required this.carId,
    required this.carName,
    required this.carModel,
    required this.carColor,
    required this.carImage,
    required this.rentalPrice,
    required this.isActive,
    this.createdAt,
    required this.car,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    id: json["id"] ?? 0,
    carId: json["id"] ?? 0, // هنا خدت id ك carId
    carName: json["name"]?.toString() ?? '',
    carModel: json["model"]?.toString() ?? '',
    carColor: '', // JSON مش فيه carColor مباشر
    carImage: json["main_image"]?.toString() ?? '',
    rentalPrice: json["rental_price"]?.toString() ?? '0',
    isActive: (json["is_active"] ?? 0) == 1,
    createdAt: null,
    car: Car.fromJson(json), // خد كل الـ car info من JSON نفسه
  );

}

class Car {
  int id;
  String name;
  String model;
  String color;
  String mainImage;
  String rentalPrice;
  List<Category> categories;
  List<Feature> features;

  Car({
    required this.id,
    required this.name,
    required this.model,
    required this.color,
    required this.mainImage,
    required this.rentalPrice,
    required this.categories,
    required this.features,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? '',
    model: json["model"]?.toString() ?? '',
    color: json["color"]?.toString() ?? '',
    mainImage: json["main_image"]?.toString() ?? '',
    rentalPrice: json["rental_price"]?.toString() ?? '0',
    categories: json["categories"] != null
        ? List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x)))
        : [],
    features: json["features"] != null
        ? List<Feature>.from(json["features"].map((x) => Feature.fromJson(x)))
        : [],
  );

  /// إنشاء Car فارغ كـ fallback
  factory Car.empty() => Car(
    id: 0,
    name: '',
    model: '',
    color: '',
    mainImage: '',
    rentalPrice: '0',
    categories: [],
    features: [],
  );
}

class Category {
  int id;
  String name;
  String slug;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? '',
    slug: json["slug"]?.toString() ?? '',
    image: json["image"]?.toString() ?? '',
  );
}

class Feature {
  int featureId;
  String featureName;
  int valueId;
  String value;

  Feature({
    required this.featureId,
    required this.featureName,
    required this.valueId,
    required this.value,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    featureId: json["feature_id"] ?? 0,
    featureName: json["feature_name"]?.toString() ?? '',
    valueId: json["value_id"] ?? 0,
    value: json["value"]?.toString() ?? '',
  );
}
