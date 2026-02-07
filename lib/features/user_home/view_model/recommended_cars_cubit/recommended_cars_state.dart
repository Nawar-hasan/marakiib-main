import 'package:marakiib_app/features/user_home/data/models/recommended_car_model.dart';

abstract class RecommendedCarState {}

class RecommendedCarInitial extends RecommendedCarState {}

class RecommendedCarLoading extends RecommendedCarState {}

class RecommendedCarLoaded extends RecommendedCarState {
  final List<RecommendedCarModel> recommendedCars;

  RecommendedCarLoaded(this.recommendedCars);
}

class RecommendedCarError extends RecommendedCarState {
  final String message;

  RecommendedCarError(this.message);
}
