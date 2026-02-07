import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/chat/data/models/message_model.dart';

class MessageRepo {
  final Dio dio;

  MessageRepo({required this.dio});


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

  // ✅ Get Messages
  Future<MessageResponse> getMessages(int conversationId) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.getChat}$conversationId/messages",
        options: options,
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final messageResponse = MessageResponse.fromJson(response.data);
      return messageResponse;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }

  // ✅ Mark Conversation as Read
  Future<void> markConversationAsRead(int conversationId) async {
    try {
      final options = await _getOptions();
      await dio.post(
        "${EndPoints.baseUrl}conversations/$conversationId/read",
        options: options,
      );
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }

  // ✅ Send Message
  Future<Message> sendMessage(int conversationId, String text) async {
    try {
      final options = await _getOptions();
      final response = await dio.post(
        "${EndPoints.baseUrl}conversations/$conversationId/messages",
        data: {"message": text},
        options: options,
      );

      print("Response Data: ${response.data}");
      final data = response.data['data'];
      if (data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      return Message.fromJson(data);
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
