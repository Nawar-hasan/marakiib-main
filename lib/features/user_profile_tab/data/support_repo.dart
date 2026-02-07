import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_profile_tab/data/support_model.dart';

class SupportRepository {
  final Dio dio;

  SupportRepository(this.dio);

  Future<SupportModel> sendSupportMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await dio.post(
        '${EndPoints.baseUrl}${EndPoints.pageSupport}',
        data: {
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
        },
      );

      return SupportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to send support message');
    }
  }
}
