import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/features/user_home/data/repository/recommended_car_repo.dart';
import 'package:marakiib_app/features/user_home/view_model/recommended_cars_cubit/recommended_cars_state.dart';

class RecommendedCarsCubit extends Cubit<RecommendedCarState> {
  final RecommendedCarRepo recommendedCarRepo;

  RecommendedCarsCubit({required this.recommendedCarRepo})
      : super(RecommendedCarInitial());

  Future<void> getRecommendedCars() async {
    emit(RecommendedCarLoading());
    try {
      final response = await recommendedCarRepo.getRecommendedCars();

      if (isClosed) return; // ✅ stop if cubit closed
      emit(RecommendedCarLoaded(response));
    } on ServerExceptions catch (e) {
      if (isClosed) return; // ✅ stop if cubit closed
      emit(RecommendedCarError(e.errorModel.message));
    } catch (e) {
      if (isClosed) return; // ✅ stop if cubit closed
      emit(RecommendedCarError("Something went wrong: $e"));
    }
  }
}
