class PrivacyModel {
  final int id;
  final String slug;
  final bool isActive;
  final int sortOrder;
  final String locale;
  final String title;
  final String content;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String? image;
  final String? imageAlt;

  PrivacyModel({
    required this.id,
    required this.slug,
    required this.isActive,
    required this.sortOrder,
    required this.locale,
    required this.title,
    required this.content,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.image,
    this.imageAlt,
  });

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      locale: json['locale'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      image: json['image'],
      imageAlt: json['image_alt'],
    );
  }
}
