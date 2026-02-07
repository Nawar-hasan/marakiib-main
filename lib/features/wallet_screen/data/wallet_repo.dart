import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/wallet_screen/data/balanc_model.dart';

class WalletRepository {
  final Dio dio;

  WalletRepository(this.dio);

  Future<WalletModel> getWalletBalance() async {
    final token = CacheHelper.getString("token") ?? "";
    final response = await dio.get(
      '${EndPoints.baseUrl}${EndPoints.walletBalance}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      return WalletModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to fetch wallet balance');
    }
  }
}
