class BannersResponse {
  final List<BannerModel> data;

  BannersResponse({required this.data});

  factory BannersResponse.fromJson(Map<String, dynamic> json) {
    return BannersResponse(
      data: (json['data'] as List).map((e) => BannerModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList()};
  }
}

class BannerModel {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String backgroundImage;
  final int order;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundImage,
    required this.order,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'background_image': backgroundImage,
      'order': order,
    };
  }
}
