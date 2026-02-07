class MyFeatureModel {
  final int id;
  final String slug;
  final String type;
  final String? image;
  final bool isRequired;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final List<MyFeatureValue> values;

  MyFeatureModel({
    required this.id,
    required this.slug,
    required this.type,
    this.image,
    required this.isRequired,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.values,
  });

  factory MyFeatureModel.fromJson(Map<String, dynamic> json) {
    return MyFeatureModel(
      id: json['id'],
      slug: json['slug'],
      type: json['type'],
      image: json['image'],
      isRequired: json['is_required'] == 1,
      isActive: json['is_active'] == 1,
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      values: (json['values'] as List)
          .map((value) => MyFeatureValue.fromJson(value))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'type': type,
      'image': image,
      'is_required': isRequired ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'sort_order': sortOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'values': values.map((value) => value.toJson()).toList(),
    };
  }
}

class MyFeatureValue {
  final int id;
  final int featureId;
  final String slug;
  final String? image;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final List<MyFeatureTranslation> translations;

  MyFeatureValue({
    required this.id,
    required this.featureId,
    required this.slug,
    this.image,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  factory MyFeatureValue.fromJson(Map<String, dynamic> json) {
    return MyFeatureValue(
      id: json['id'],
      featureId: json['feature_id'],
      slug: json['slug'],
      image: json['image'],
      isActive: json['is_active'] == 1,
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      translations: (json['translations'] as List)
          .map((translation) => MyFeatureTranslation.fromJson(translation))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feature_id': featureId,
      'slug': slug,
      'image': image,
      'is_active': isActive ? 1 : 0,
      'sort_order': sortOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'translations': translations.map((translation) => translation.toJson()).toList(),
    };
  }

  // Helper method to get translation by locale
  String getTranslation(String locale) {
    final translation = translations.firstWhere(
          (t) => t.locale == locale,
      orElse: () => translations.first,
    );
    return translation.value;
  }
}

class MyFeatureTranslation {
  final int id;
  final int featureValueId;
  final String locale;
  final String value;
  final String? description;
  final String createdAt;
  final String updatedAt;

  MyFeatureTranslation({
    required this.id,
    required this.featureValueId,
    required this.locale,
    required this.value,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyFeatureTranslation.fromJson(Map<String, dynamic> json) {
    return MyFeatureTranslation(
      id: json['id'],
      featureValueId: json['feature_value_id'],
      locale: json['locale'],
      value: json['value'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feature_value_id': featureValueId,
      'locale': locale,
      'value': value,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class MyFeaturesResponse {
  final List<MyFeatureModel> data;

  MyFeaturesResponse({required this.data});

  factory MyFeaturesResponse.fromJson(Map<String, dynamic> json) {
    return MyFeaturesResponse(
      data: (json['data'] as List)
          .map((feature) => MyFeatureModel.fromJson(feature))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((feature) => feature.toJson()).toList(),
    };
  }
}
