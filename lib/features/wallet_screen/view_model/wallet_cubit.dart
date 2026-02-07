import 'package:bloc/bloc.dart';
import 'package:marakiib_app/features/wallet_screen/data/wallet_repo.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_state.dart';


class WalletCubit extends Cubit<WalletState> {
  final WalletRepository repository;

  WalletCubit(this.repository) : super(WalletInitial());

  Future<void> fetchWalletBalance() async {
    emit(WalletLoading());
    try {
      final wallet = await repository.getWalletBalance();
      emit(WalletSuccess(wallet));
    } catch (e) {
      emit(WalletFailure(e.toString()));
    }
  }
}
