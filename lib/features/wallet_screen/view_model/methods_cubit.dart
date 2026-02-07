import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/wallet_screen/data/methods.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/methods_state.dart';
import '../../../core/cash/shared.dart';
import '../../../core/network/end_point.dart';

class WithdrawalMethodsCubit extends Cubit<WithdrawalMethodsState> {
  final Dio dio;

  WithdrawalMethodsCubit(this.dio) : super(WithdrawalMethodsInitial());

  Future<void> getWithdrawalMethods() async {
    emit(WithdrawalMethodsLoading());

    try {
      String? token = CacheHelper.getString("token");

      dio.options.headers = {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      };

      final response =
      await dio.get("${EndPoints.baseUrl}${EndPoints.withdrawalMethods}");

      final data = (response.data as List)
          .map((json) => WithdrawalMethod.fromJson(json))
          .toList();

      emit(WithdrawalMethodsSuccess(data));
    } catch (e) {
      emit(WithdrawalMethodsFailure(e.toString()));
    }
  }
}
