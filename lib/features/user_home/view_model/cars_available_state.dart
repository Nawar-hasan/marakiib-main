
import 'package:marakiib_app/features/user_home/data/models/car_available.dart';

abstract class CarsAvailableState {}

class CarsAvailableInitial extends CarsAvailableState {}

class CarsAvailableLoading extends CarsAvailableState {}

class CarsAvailableSuccess extends CarsAvailableState {
  final List<CarsAvailableModel> cars;

  CarsAvailableSuccess(this.cars);
}

class CarsAvailableFailure extends CarsAvailableState {
  final String error;

  CarsAvailableFailure(this.error);
}
