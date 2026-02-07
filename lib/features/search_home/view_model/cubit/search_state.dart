import 'package:marakiib_app/features/search_home/data/models/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<CarModel> cars;

  SearchSuccess(this.cars);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
