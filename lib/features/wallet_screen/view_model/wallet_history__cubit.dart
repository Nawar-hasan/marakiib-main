import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/wallet_screen/data/wallet_history.dart';
import 'wallet_history__state.dart';

class WalletHistoryCubit extends Cubit<WalletHistoryState> {
  final Dio dio;
  WalletHistoryCubit(this.dio) : super(WalletHistoryInitial());

  Future<void> getHistory() async {
    emit(WalletHistoryLoading());

    try {
      // 🟢 جلب التوكن من SharedPreferences
      final token = CacheHelper.getString("token");
      if (token == null) {
        emit(WalletHistoryFailure("Token not found"));
        return;
      }

      // 🟢 إعداد الهيدر
      dio.options.headers["Authorization"] = "Bearer $token";

      // 🟢 عمل الطلب
      final response = await dio.get('${EndPoints.baseUrl}${EndPoints.wallethistory}');

      final List data = response.data['data'];
      final histories = data.map((e) => WalletHistory.fromJson(e)).toList();

      emit(WalletHistorySuccess(histories));
    } catch (e) {
      emit(WalletHistoryFailure(e.toString()));
    }
  }
}
