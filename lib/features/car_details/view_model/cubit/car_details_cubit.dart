import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/features/car_details/data/repository/car_details_repo.dart';
import 'car_details_state.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  final CarDetailsRepo carDetailsRepo;

  CarDetailsCubit({required this.carDetailsRepo}) : super(CarDetailsInitial());

  Future<void> getCarDetails({required int carId, String locale = 'en'}) async {
    emit(CarDetailsLoading());
    try {
      final carDetails = await carDetailsRepo.getCarDetails(
        carId: carId,
        locale: locale,
      );
      emit(CarDetailsLoaded(carDetails));
    } on ServerExceptions catch (e) {
      emit(CarDetailsError(e.errorModel.message));
    } catch (e) {
      emit(CarDetailsError("Something went wrong: $e"));
    }
  }
}
