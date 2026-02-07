import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/auth/forget_password/data/rest_password.dart';
import 'package:marakiib_app/features/auth/forget_password/view_model/rest_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordService resetPasswordService;

  ResetPasswordCubit(this.resetPasswordService)
      : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otpCode,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final response = await resetPasswordService.resetPassword(
        email: email,
        otpCode: otpCode,
        password: password,
        confirmPassword: confirmPassword,
      );

      emit(ResetPasswordSuccess(
          response.data['message'] ?? 'تم تغيير كلمة المرور بنجاح'));
    } on DioException catch (dioError) {
      String errorMessage = 'حدث خطأ، حاول مرة أخرى لاحقًا';

      if (dioError.response != null) {
        final data = dioError.response?.data;

        if (data is Map && data.containsKey('message')) {
          errorMessage = data['message'];
        } else {
          switch (dioError.response?.statusCode) {
            case 400:
              errorMessage = 'البيانات المدخلة غير صحيحة';
              break;
            case 401:
              errorMessage = 'رمز التحقق غير صالح أو منتهي الصلاحية';
              break;
            case 404:
              errorMessage = 'البريد الإلكتروني غير موجود';
              break;
            case 302:
              errorMessage = 'حدث خطأ أثناء إرسال الطلب، حاول مرة أخرى';
              break;
            case 500:
              errorMessage = 'مشكلة في الخادم، حاول لاحقًا';
              break;
          }
        }
      }

      emit(ResetPasswordFailure(errorMessage));
    } catch (e) {
      emit(ResetPasswordFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }
}
