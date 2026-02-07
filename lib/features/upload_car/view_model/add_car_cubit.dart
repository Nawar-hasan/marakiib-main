import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/features/upload_car/data/add_car_service.dart';
import 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  final AddCarService addCarService;

  AddCarCubit(this.addCarService) : super(AddCarInitial());

  Future<void> addCar(FormData formData) async {
    emit(AddCarLoading());
    try {
      final response = await addCarService.addCar(formData);
      final message = response.data != null && response.data['message'] != null
          ? response.data['message']
          : "تمت إضافة السيارة بنجاح";
      emit(AddCarSuccess(message));
    } catch (e) {
      emit(AddCarFailure('Failed to add car'));
    }
  }
}
