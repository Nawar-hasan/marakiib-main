
abstract class SendFcmState {}
class SendFcmInitial extends SendFcmState {}
class SendFcmLoading extends SendFcmState {}
class SendFcmSuccess extends SendFcmState {}
class SendFcmError extends SendFcmState {
  final String message;
  SendFcmError(this.message);
}
