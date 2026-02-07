import 'package:marakiib_app/features/user_notifications/view/data/notification_model.dart';


abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<GetNotificationModel> notifications;

  NotificationSuccess(this.notifications);
}

class NotificationFailure extends NotificationState {
  final String error;

  NotificationFailure(this.error);
}
class UnreadCountLoading extends NotificationState {}

class UnreadCountSuccess extends NotificationState {
  final int count;
  UnreadCountSuccess(this.count);
  @override
  List<Object> get props => [count];
}

class UnreadCountFailure extends NotificationState {
  final String message;
  UnreadCountFailure(this.message);
  @override
  List<Object> get props => [message];
}
