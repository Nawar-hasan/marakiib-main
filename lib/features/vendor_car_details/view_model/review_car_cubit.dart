import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_car_details/view/data/reviews_repo.dart';
import 'package:marakiib_app/features/vendor_car_details/view_model/review_car_state.dart';

class CarReviewCubit extends Cubit<CarReviewState> {
  final CarReviewService service;

  CarReviewCubit(this.service) : super(CarReviewInitial());

  Future<void> getCarReviews(int carId) async {
    emit(CarReviewLoading());
    try {
      final reviews = await service.getCarReviews(carId);
      emit(CarReviewSuccess(reviews));
    } catch (e) {
      emit(CarReviewError(e.toString()));
    }
  }
}
