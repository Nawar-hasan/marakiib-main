import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../data/subscription_model.dart';
import 'subscription_state.dart';
import '../../../../core/network/end_point.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final Dio dio;

  SubscriptionCubit(this.dio) : super(SubscriptionInitial());

  Future<void> fetchPlans(String token) async {
    emit(SubscriptionLoading());
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(
        '${EndPoints.baseUrl}${EndPoints.subscriptionsplans}',
      );

      if (response.data["success"] == true) {
        final List data = response.data["data"];
        final plans = data.map((e) => SubscriptionPlan.fromJson(e)).toList();
        emit(SubscriptionLoaded(plans));
      } else {
        emit(SubscriptionError("لا يوجد خطط متاحة حالياً"));
      }
    } catch (e) {
      emit(SubscriptionError("حدث خطأ أثناء جلب البيانات: $e"));
    }
  }

  Future<void> purchasePlan(String token, int planId) async {
    emit(SubscriptionLoading());
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.post(
        '${EndPoints.baseUrl}${EndPoints.subscriptionsPurchase}',
        data: {"plan_id": planId},
      );

      if (response.data["success"] == true) {
        emit(
          SubscriptionPurchased(
            response.data["message"] ?? "تم تفعيل الاشتراك بنجاح",
          ),
        );
      } else {
        emit(SubscriptionError("حدث خطأ أثناء تفعيل الاشتراك"));
      }
    } catch (e) {
      emit(SubscriptionError(""));
    }
  }
}
