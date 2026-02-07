import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_home/data/models/financed_car_model.dart';
import 'package:marakiib_app/features/user_home/data/repository/financed_cars.dart';
import 'package:marakiib_app/features/user_home/view_model/financed_cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final CarsService _service;

  CarsCubit(this._service) : super(CarsInitial());

  Future<void> getFinancedCars() async {
    emit(CarsLoading());
    try {
      final cars = await _service.fetchFinancedCars();
      emit(CarsLoaded(cars));
    } catch (e) {
      emit(CarsError(e.toString()));
    }
  }
}
