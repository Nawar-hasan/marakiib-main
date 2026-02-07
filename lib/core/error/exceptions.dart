import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';

class ServerExceptions implements Exception {
  final ErrorModel errorModel;

  ServerExceptions({required this.errorModel});

  @override
  String toString() => errorModel.message;
}

ServerExceptions handleDioException(DioException e) {
  // لو فيه response و data → نعمل parsing للـ ErrorModel
  if (e.response != null && e.response?.data != null) {
    try {
      return ServerExceptions(
        errorModel: ErrorModel.fromJson(e.response!.data),
      );
    } catch (_) {
      // fallback لو السيرفر رجع data مش متوافقة
      return ServerExceptions(
        errorModel: ErrorModel(message: "Unexpected server response format."),
      );
    }
  }

  // التعامل مع أنواع الأخطاء
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ServerExceptions(
        errorModel: ErrorModel(
          message: "Connection timed out, please try again.",
        ),
      );

    case DioExceptionType.cancel:
      return ServerExceptions(
        errorModel: ErrorModel(message: "Request was cancelled."),
      );

    case DioExceptionType.connectionError:
      return ServerExceptions(
        errorModel: ErrorModel(message: "No internet connection."),
      );

    case DioExceptionType.badCertificate:
      return ServerExceptions(
        errorModel: ErrorModel(message: "Bad SSL certificate."),
      );

    case DioExceptionType.unknown:
      return ServerExceptions(
        errorModel: ErrorModel(message: "Unexpected error occurred."),
      );

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
        case 422:
          return ServerExceptions(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 500:
        case 502:
        case 503:
        case 504:
          return ServerExceptions(
            errorModel: ErrorModel(
              message: "Server error, please try again later.",
            ),
          );
        default:
          return ServerExceptions(
            errorModel: ErrorModel(
              message: "Unexpected server response ($statusCode).",
            ),
          );
      }
  }
}
