abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final String message;

  VerifyOtpSuccess(this.message);
}

class VerifyOtpFailure extends VerifyOtpState {
  final String error;

  VerifyOtpFailure(this.error);
}
