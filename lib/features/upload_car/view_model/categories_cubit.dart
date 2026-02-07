import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await Dio().get("${EndPoints.baseUrl}${EndPoints.categories}");

      if (response.statusCode == 200) {
        final List data = response.data["data"];
        final categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        emit(CategoriesSuccess(categories));
      } else {
        emit(CategoriesFailure("Failed with status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }
}
