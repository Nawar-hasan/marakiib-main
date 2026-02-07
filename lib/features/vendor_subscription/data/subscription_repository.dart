import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/vendor_subscription/data/models/my_subscription_model.dart';

class SubscriptionRepository {
  final Dio dio;

  SubscriptionRepository(this.dio);

  Future<MySubscriptionModel> fetchMySubscription() async {
    try {
      final token = await CacheHelper.getString("token");
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await dio.get(
        '${EndPoints.baseUrl}subscriptions/my',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return MySubscriptionModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch subscription');
      }
    } catch (e) {
      throw Exception('Error fetching subscription: $e');
    }
  }
}
