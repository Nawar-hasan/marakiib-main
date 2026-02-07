import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/auth/forget_password/data/forget_password_service.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordService forgetPasswordService;

  ForgetPasswordCubit(this.forgetPasswordService)
      : super(ForgetPasswordInitial());

  Future<void> forgetPassword(String email, String otpMethod) async {
    emit(ForgetPasswordLoading());
    try {
      final response = await forgetPasswordService.forgetPassword(
        email: email,
        otpMethod: otpMethod,
      );

      emit(ForgetPasswordSuccess(response.data['message'] ?? 'Check your email'));
    } on DioException catch (dioError) {
      String errorMessage = 'حدث خطأ، حاول مرة أخرى لاحقًا';

      if (dioError.response != null) {
        final data = dioError.response?.data;

        if (data is Map && data.containsKey('message')) {
          errorMessage = data['message'];
        } else {
          switch (dioError.response?.statusCode) {
            case 404:
            case 302:
              errorMessage = 'البريد الإلكتروني غير موجود';
              break;
            case 500:
              errorMessage = 'مشكلة في الخادم، حاول لاحقًا';
              break;
          }
        }
      }

      emit(ForgetPasswordFailure(errorMessage));
    } catch (e) {
      emit(ForgetPasswordFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }
}
