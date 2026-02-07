import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesFailure extends CategoriesState {
  final String error;

  CategoriesFailure(this.error);
}
