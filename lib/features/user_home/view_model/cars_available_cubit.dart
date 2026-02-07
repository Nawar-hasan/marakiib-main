import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_home/data/models/car_available.dart';
import 'package:marakiib_app/features/user_home/view_model/cars_available_cubit.dart';
import 'package:marakiib_app/features/user_home/view_model/cars_available_state.dart';



class CarsAvailableCubit extends Cubit<CarsAvailableState> {
  CarsAvailableCubit() : super(CarsAvailableInitial());

  static CarsAvailableCubit get(context) => BlocProvider.of(context);

  List<CarsAvailableModel> cars = [];

  Future<void> getCarsAvailable() async {
    emit(CarsAvailableLoading());
    try {
      final response = await Dio().get(
        EndPoints.baseUrl + EndPoints.carsAvailable,
      );

      final List data = response.data['data'];
      cars = data.map((e) => CarsAvailableModel.fromJson(e)).toList();

      emit(CarsAvailableSuccess(cars));
    } catch (e) {
      emit(CarsAvailableFailure(e.toString()));
    }
  }
}
