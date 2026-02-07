import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'is_favorite_state.dart';

class IsFavouriteCubit extends Cubit<IsFavouriteState> {
  final Dio dio;

  IsFavouriteCubit({required this.dio}) : super(IsFavouriteInitial());

  Future<void> getIsFavourite(int carId) async {
    print('🔵 getIsFavourite called for carId: $carId');
    emit(IsFavouriteLoading());

    try {
      final token = CacheHelper.getString("token") ?? '';
      print('🔵 Token: ${token.isNotEmpty ? "Found" : "Not Found"}');

      final response = await dio.get(
          EndPoints.baseUrl+EndPoints.isfavorite(carId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('🟢 Response Status: ${response.statusCode}');
      print('🟢 Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data['data'] != null) {
        final isFav = response.data['data']['is_favorite'] as bool;
        print('✅ is_favorite: $isFav');

        emit(IsFavouriteLoaded(isFavorite: isFav, carId: carId));
      } else {
        print('❌ Invalid response structure');
        emit(IsFavouriteError('Failed to fetch favourite status'));
      }
    } catch (e) {
      print('🔴 Error: $e');
      emit(IsFavouriteError(e.toString()));
    }
  }

  // دالة للتحديث الفوري (Optimistic Update)
  void updateLocalState(bool isFavorite, int carId) {
    print('🔄 Updating local state: isFavorite=$isFavorite, carId=$carId');
    emit(IsFavouriteLoaded(isFavorite: isFavorite, carId: carId));
  }
}
