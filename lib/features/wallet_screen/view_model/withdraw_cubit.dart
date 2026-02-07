import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/withdraw_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/withdraw_state.dart';
import '../../../core/cash/shared.dart';
import '../../../core/network/end_point.dart';


class WithdrawCubit extends Cubit<WithdrawState> {
  final Dio dio;

  WithdrawCubit(this.dio) : super(WithdrawInitial());

  Future<void> withdraw({
    required int methodId,
    required double amount,
    required Map<String, dynamic> details,
  }) async {
    emit(WithdrawLoading());
    try {
      final token = CacheHelper.getString("token");
      dio.options.headers = {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      };

      final response = await dio.post(
        "${EndPoints.baseUrl}${EndPoints.withdraw}",
        data: {
          "withdrawal_method_id": methodId,
          "amount": amount,
          "details": details,
        },
      );

      emit(WithdrawSuccess(response.data["message"] ?? "تم السحب بنجاح"));
    } catch (e) {
      emit(WithdrawFailure(e.toString()));
    }
  }
}
