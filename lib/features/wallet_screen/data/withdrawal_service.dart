import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/wallet_screen/data/methods.dart';

class WithdrawalService {
  final Dio dio;

  WithdrawalService(this.dio) {
    final token = CacheHelper.getString("token");

    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
  }

  Future<List<WithdrawalMethod>> getWithdrawalMethods() async {
    final response = await dio.get(EndPoints.withdrawalMethods);

    return (response.data as List)
        .map((json) => WithdrawalMethod.fromJson(json))
        .toList();
  }
}
