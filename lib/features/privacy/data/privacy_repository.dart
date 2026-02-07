import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/privacy/data/model/privacy_model.dart';

class PrivacyRepository {
  final Dio dio;

  PrivacyRepository(this.dio);

  Future<PrivacyModel> getPrivacyPage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lang = prefs.getString('langCode') ?? 'ar';

      final response = await dio.get(
        '${EndPoints.baseUrl}${EndPoints.pagesPrivacy}',
        options: Options(
          headers: {
            'Accept-Language': lang,
            'Accept': 'application/json',
          },
        ),
      );

      final data =
      response.data is Map<String, dynamic> && response.data.containsKey('data')
          ? response.data['data']
          : response.data;

      return PrivacyModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to load privacy page',
      );
    }
  }
}
