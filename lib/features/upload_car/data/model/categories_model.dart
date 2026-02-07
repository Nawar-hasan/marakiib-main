class CategoryTranslation {
  final int id;
  final int categoryId;
  final String locale;
  final String name;
  final String description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;

  CategoryTranslation({
    required this.id,
    required this.categoryId,
    required this.locale,
    required this.name,
    required this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
  });

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) {
    return CategoryTranslation(
      id: json['id'],
      categoryId: json['category_id'],
      locale: json['locale'],
      name: json['name'],
      description: json['description'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      imageAlt: json['image_alt'],
    );
  }
}

class CategoryModel {
  final int id;
  final String slug;
  final String? image;
  final int isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String name;
  final String description;
  final String? metaTitle;
  final String? metaDescription;
  final String? imageAlt;
  final List<CategoryTranslation> translations;

  CategoryModel({
    required this.id,
    required this.slug,
    required this.image,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.description,
    this.metaTitle,
    this.metaDescription,
    this.imageAlt,
    required this.translations,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      slug: json['slug'],
      image: json['image'],
      isActive: json['is_active'],
      sortOrder: json['sort_order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      name: json['name'],
      description: json['description'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      imageAlt: json['image_alt'],
      translations: (json['translations'] as List)
          .map((e) => CategoryTranslation.fromJson(e))
          .toList(),
    );
  }
}
