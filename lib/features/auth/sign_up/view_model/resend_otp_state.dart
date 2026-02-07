abstract class ResendOtpState {}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {
  final String message;
  ResendOtpSuccess(this.message);
}

class ResendOtpError extends ResendOtpState {
  final String error;
  ResendOtpError(this.error);
}
