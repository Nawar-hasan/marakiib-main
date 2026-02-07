import 'package:marakiib_app/features/vendor_financings/data/models/financed_car_model.dart';

abstract class FinancedCarsState {}

class FinancedCarsInitial extends FinancedCarsState {}

class FinancedCarsLoading extends FinancedCarsState {}

class FinancedCarsSuccess extends FinancedCarsState {
  final List<FinancedCarModel> financedCars;

  FinancedCarsSuccess(this.financedCars);
}

class FinancedCarsFailure extends FinancedCarsState {
  final String error;

  FinancedCarsFailure(this.error);
}
