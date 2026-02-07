import 'package:marakiib_app/features/privacy/data/model/privacy_model.dart';


abstract class PrivacyState {}

class PrivacyInitial extends PrivacyState {}

class PrivacyLoading extends PrivacyState {}

class PrivacySuccess extends PrivacyState {
  final PrivacyModel privacy;
  PrivacySuccess(this.privacy);
}

class PrivacyError extends PrivacyState {
  final String message;
  PrivacyError(this.message);
}
