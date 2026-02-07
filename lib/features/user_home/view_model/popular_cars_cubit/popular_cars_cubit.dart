import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/features/user_home/data/models/popular_car_model.dart';
import 'package:marakiib_app/features/user_home/data/repository/popular_car_repo.dart';
import 'package:marakiib_app/features/user_home/view_model/popular_cars_cubit/popular_cars_state.dart';

class PopularCarCubit extends Cubit<PopularCarState> {
  final PopularCarRepo repo;

  PopularCarCubit(this.repo) : super(PopularCarInitial());

  Future<void> fetchPopularCars() async {
    emit(PopularCarLoading());
    try {
      final cars = await repo.getPopularCarList();

      if (isClosed) {
        return;
      }

      emit(PopularCarLoaded(cars));
    } catch (e) {
      if (isClosed) return; // ✅ نفس الفكرة

      emit(PopularCarError(e.toString()));
    }
  }
}
