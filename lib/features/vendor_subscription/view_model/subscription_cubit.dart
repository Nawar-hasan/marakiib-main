import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_subscription/data/subscription_repository.dart';
import 'package:marakiib_app/features/vendor_subscription/view_model/subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository repository;

  SubscriptionCubit(this.repository) : super(SubscriptionInitial());

  Future<void> fetchMySubscription() async {
    emit(SubscriptionLoading());
    try {
      final subscription = await repository.fetchMySubscription();
      emit(SubscriptionSuccess(subscription));
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }
}
