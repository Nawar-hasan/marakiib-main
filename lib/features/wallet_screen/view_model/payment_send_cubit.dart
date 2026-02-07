import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/payment_send_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final Dio dio;

  PaymentCubit(this.dio) : super(PaymentInitial());

  Future<void> createPaymentSession({
    required double amount,
    required String currency,
    required String description,
  }) async {
    emit(PaymentLoading());

    try {
      final token = CacheHelper.getString("token");

      if (token == null) {
        emit(PaymentFailure("User token not found"));
        return;
      }

      final body = {
        "amount": amount,
        "currency": currency,
        "description": description,
      };

      final response = await dio.post(
        EndPoints.baseUrl + EndPoints.payment,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      emit(PaymentSuccess(response.data));

    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? "خطأ أثناء إنشاء جلسة الدفع";
      emit(PaymentFailure(msg));

    } catch (e) {
      emit(PaymentFailure("مشكلة في الاتصال بالسيرفر"));
    }
  }
}
