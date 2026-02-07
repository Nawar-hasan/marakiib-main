import '../data/subscription_model.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<SubscriptionPlan> plans;
  SubscriptionLoaded(this.plans);
}
class SubscriptionPurchased extends SubscriptionState {
  final String message;
  SubscriptionPurchased(this.message);
}
class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}
