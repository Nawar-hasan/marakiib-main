import 'package:marakiib_app/features/vendor_subscription/data/models/my_subscription_model.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionSuccess extends SubscriptionState {
  final MySubscriptionModel subscription;

  SubscriptionSuccess(this.subscription);
}

class SubscriptionFailure extends SubscriptionState {
  final String error;

  SubscriptionFailure(this.error);
}
