
import 'package:marakiib_app/features/wallet_screen/data/methods.dart';

abstract class WithdrawalMethodsState {}

class WithdrawalMethodsInitial extends WithdrawalMethodsState {}

class WithdrawalMethodsLoading extends WithdrawalMethodsState {}

class WithdrawalMethodsSuccess extends WithdrawalMethodsState {
  final List<WithdrawalMethod> methods;

  WithdrawalMethodsSuccess(this.methods);
}

class WithdrawalMethodsFailure extends WithdrawalMethodsState {
  final String error;

  WithdrawalMethodsFailure(this.error);
}
