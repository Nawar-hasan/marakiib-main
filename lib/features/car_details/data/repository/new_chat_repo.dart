import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/car_details/data/models/new_chat_model.dart';

class NewChatRepo {
  final Dio dio;

  NewChatRepo({required this.dio});

  // دالة داخلية لجلب الهيدر مع التوكن
  Future<Options> _getOptions() async {
    final token = CacheHelper.getString("token") ?? '';
    return Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Language": "en",
        "Authorization": "Bearer $token",
      },
    );
  }

  // ✅ إنشاء محادثة جديدة
  Future<NewChatModel> createChat({required int receiverId}) async {
    try {
      final options = await _getOptions();
      final response = await dio.post(
        "${EndPoints.baseUrl}${EndPoints.startnewchat}",
        data: {"renter_id": receiverId},
        options: options,
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final conversation = NewChatModel.fromJson(response.data);
      return conversation;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
