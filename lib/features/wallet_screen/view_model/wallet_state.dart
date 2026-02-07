import 'package:bloc/bloc.dart';
import 'package:marakiib_app/features/wallet_screen/data/balanc_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletSuccess extends WalletState {
  final WalletModel wallet;
  WalletSuccess(this.wallet);
}

class WalletFailure extends WalletState {
  final String error;
  WalletFailure(this.error);
}

