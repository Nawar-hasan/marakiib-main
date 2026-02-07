import 'package:marakiib_app/features/user_home/data/models/financed_car_model.dart';

abstract class CarsState {}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

class CarsLoaded extends CarsState {
  final List<FinancedCarModel> cars;
  CarsLoaded(this.cars);
}

class CarsError extends CarsState {
  final String message;
  CarsError(this.message);
}
