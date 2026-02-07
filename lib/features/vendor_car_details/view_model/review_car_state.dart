import 'package:marakiib_app/features/vendor_car_details/view/data/reviews_car_model.dart';

abstract class CarReviewState {}

class CarReviewInitial extends CarReviewState {}

class CarReviewLoading extends CarReviewState {}

class CarReviewSuccess extends CarReviewState {
  final List<CarReviewModel> reviews;
  CarReviewSuccess(this.reviews);
}

class CarReviewError extends CarReviewState {
  final String error;
  CarReviewError(this.error);
}
