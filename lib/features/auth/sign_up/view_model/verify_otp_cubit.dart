import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/data/data_source/verify_otp_repository.dart';
import '../view/data/model/verify_otp_model.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpRepository repository;

  VerifyOtpCubit(this.repository) : super(VerifyOtpInitial());

  Future<void> verifyOtp(VerifyOtpModel data) async {
    emit(VerifyOtpLoading());
    try {
      final response = await repository.verifyOtp(data);
      emit(VerifyOtpSuccess(response.data["message"] ?? "OTP Verified Successfully"));
    } catch (e) {
      emit(VerifyOtpFailure('خطا ف الكود غير صحيح'));
    }
  }
}
