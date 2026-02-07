import 'package:marakiib_app/features/user_home/data/models/popular_car_model.dart';

abstract class PopularCarState {}

class PopularCarInitial extends PopularCarState {}

class PopularCarLoading extends PopularCarState {}

class PopularCarLoaded extends PopularCarState {
  final List<PopularCarModel> popularcars;

  PopularCarLoaded(this.popularcars);
}

class PopularCarError extends PopularCarState {
  final String message;

  PopularCarError(this.message);
}
