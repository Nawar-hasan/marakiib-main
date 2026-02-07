import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_financings/data/financed_cars_repository.dart';
import 'package:marakiib_app/features/vendor_financings/view_model/financed_cars_state.dart';

class FinancedCarsCubit extends Cubit<FinancedCarsState> {
  final FinancedCarsRepository repository;

  FinancedCarsCubit(this.repository) : super(FinancedCarsInitial());

  Future<void> fetchFinancedCars({String status = 'active'}) async {
    emit(FinancedCarsLoading());
    try {
      final financedCars = await repository.fetchFinancedCars(status: status);
      emit(FinancedCarsSuccess(financedCars));
    } catch (e) {
      emit(FinancedCarsFailure(e.toString()));
    }
  }
}
