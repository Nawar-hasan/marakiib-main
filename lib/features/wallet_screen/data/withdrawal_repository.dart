
import 'package:marakiib_app/features/wallet_screen/data/methods.dart';
import 'package:marakiib_app/features/wallet_screen/data/withdrawal_service.dart';

class WithdrawalRepository {
  final WithdrawalService service;

  WithdrawalRepository(this.service);

  Future<List<WithdrawalMethod>> getMethods() {
    return service.getWithdrawalMethods();
  }
}
