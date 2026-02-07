import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';

class ConversationsRepo {
  final Dio dio;

  ConversationsRepo({required this.dio});

  // دالة داخلية لجلب الهيدر مع التوكن
  Future<Options> _getOptions() async {
    final token = CacheHelper.getString("token") ?? '';
    return Options(
      headers: {
        "Accept": "application/json",
        "Accept-Language": "en",
        "Authorization": "Bearer $token",
      },
    );
  }

  // ✅ جلب المحادثات
  Future<List<Conversation>> getChatMessages() async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        EndPoints.baseUrl + EndPoints.viewConversations,
        options: options,
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final chatResponse = ConversationsResponse.fromJson(response.data);
      return chatResponse.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
