import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_profile_tab/data/favourites_model.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/get_favourites_state.dart';


class FavouritesFailure extends FavouritesState {
  final String error;
  FavouritesFailure(this.error);
}

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  final Dio dio = Dio();

  Future<void> fetchFavourites() async {
    emit(FavouritesLoading());

    try {
      final token = CacheHelper.getString("token") ?? "";

      if (token.isEmpty) {
        emit(FavouritesFailure("Token not found"));
        return;
      }

      final url = "${EndPoints.baseUrl}${EndPoints.favourites}";

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.data["data"] != null) {
        final favouritesList = (response.data["data"] as List)
            .map((json) => FavouriteModel.fromJson(json))
            .toList();
        emit(FavouritesSuccess(favouritesList));
      } else {
        emit(FavouritesFailure("No favourites found"));
      }
    } catch (e) {
      emit(FavouritesFailure(e.toString()));
    }
  }
}
