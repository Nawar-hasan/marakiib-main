abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final dynamic data;

  PaymentSuccess(this.data);
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}
