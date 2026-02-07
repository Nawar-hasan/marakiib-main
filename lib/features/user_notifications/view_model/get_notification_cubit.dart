// notification_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_notifications/view/data/notification_model.dart';
import 'package:marakiib_app/features/user_notifications/view_model/get_notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    try {
      final token = CacheHelper.getString("token");
      if (token == null) throw Exception("Token not found");

      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.getnotifications}",
      );

      if (response.data["status"] == "success") {
        final List notificationsJson = response.data["data"]["notifications"];
        final notifications =
            notificationsJson
                .map((e) => GetNotificationModel.fromJson(e))
                .toList();
        emit(NotificationSuccess(notifications));
      } else {
        emit(NotificationFailure("Failed to fetch notifications"));
      }
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }

  Future<void> markAsRead(GetNotificationModel notification) async {
    try {
      final token = CacheHelper.getString("token");
      if (token == null) throw Exception("Token not found");

      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.post(
        "${EndPoints.baseUrl}notifications/${notification.id}/read",
      );

      if (response.data["status"] == "success") {
        if (state is NotificationSuccess) {
          final currentState = state as NotificationSuccess;
          final updatedNotifications = currentState.notifications.map((n) {
            if (n.id == notification.id) {
              return n.copyWith(isRead: true);
            }
            return n;
          }).toList();

          // 🔥 emit نسخة جديدة من list
          emit(NotificationSuccess(List.from(updatedNotifications)));
        }
      }
    } catch (e) {
      print("Failed to mark as read: $e");
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final token = CacheHelper.getString("token");
      if (token == null) throw Exception("Token not found");

      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.unreadCount}",
      );

      if (response.statusCode == 200) {
        return response.data['unread_count'] ?? 0;
      } else {
        throw Exception('Failed to fetch unread count');
      }
    } catch (e) {
      print("Error fetching unread count: $e");
      return 0;
    }
  }
}
