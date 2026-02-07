import 'package:marakiib_app/features/user_profile_tab/data/support_model.dart';


abstract class SupportState {}

class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class SupportSuccess extends SupportState {
  final SupportModel support;
  SupportSuccess(this.support);
}

class SupportError extends SupportState {
  final String message;
  SupportError(this.message);
}
