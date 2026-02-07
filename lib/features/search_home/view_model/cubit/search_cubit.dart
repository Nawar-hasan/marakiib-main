import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/search_home/data/repository/search_repo.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCubit extends Cubit<SearchState> {
  final CarSearchRepo carSearchRepo;

  SearchCubit(this.carSearchRepo) : super(SearchInitial());

  Future<void> searchCars({
    String? query,
    double? priceMin,
    double? priceMax,
    int? carTypeId,
    bool? nearest,
    double? latitude,
    double? longitude,
    String? usageNature,
    bool? longTermGuarantee, // ✅ جديد
  }) async {
    emit(SearchLoading());
    try {
      final cars = await carSearchRepo.searchCars(
        query: query,
        priceMin: priceMin,
        priceMax: priceMax,
        carTypeId: carTypeId,
        nearest: nearest,
        latitude: latitude,
        longitude: longitude,
        usageNature: usageNature,
        longTermGuarantee: longTermGuarantee, // ✅ جديد
      );
      emit(SearchSuccess(cars));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> applyFilters({
    String? query,
    double? priceMin,
    double? priceMax,
    int? carTypeId,
    bool? nearest,
    String? usageNature,
    bool? longTermGuarantee, // ✅ جديد
  }) async {
    emit(SearchLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final latitude = prefs.getDouble("user_lat");
      final longitude = prefs.getDouble("user_lng");

      final cars = await carSearchRepo.searchCars(
        query: query,
        priceMin: priceMin,
        priceMax: priceMax,
        carTypeId: carTypeId,
        nearest: nearest,
        latitude: latitude,
        longitude: longitude,
        usageNature: usageNature,
        longTermGuarantee: longTermGuarantee, // ✅ جديد
      );

      emit(SearchSuccess(cars));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

}
