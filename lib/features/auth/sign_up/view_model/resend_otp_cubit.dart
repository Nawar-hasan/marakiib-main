import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/auth/sign_up/view_model/resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit() : super(ResendOtpInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  Future<void> resendOtp(String email, String otpMethod) async {
    emit(ResendOtpLoading());
    try {
      final response = await _dio.post(
        EndPoints.resendotp,
        data: {
          "email": email,
          "otp_method": otpMethod, // sms أو email
        },
      );

      emit(
        ResendOtpSuccess(
          response.data["message"] ?? "OTP resent successfully",
        ),
      );
    } on DioError catch (e) {
      emit(
        ResendOtpError(
          e.response?.data["message"] ?? "Something went wrong",
        ),
      );
    } catch (e) {
      emit(ResendOtpError(e.toString()));
    }
  }
}
