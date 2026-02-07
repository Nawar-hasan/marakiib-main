import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/wallet_screen/data/wallet_history.dart';

abstract class WalletHistoryState {}

class WalletHistoryInitial extends WalletHistoryState {}
class WalletHistoryLoading extends WalletHistoryState {}
class WalletHistorySuccess extends WalletHistoryState {
  final List<WalletHistory> histories;
  WalletHistorySuccess(this.histories);
}
class WalletHistoryFailure extends WalletHistoryState {
  final String error;
  WalletHistoryFailure(this.error);
}

