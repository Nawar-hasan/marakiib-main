import 'package:dio/dio.dart';
import 'package:marakiib_app/core/error/error_model.dart';
import 'package:marakiib_app/core/error/exceptions.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/user_home/data/models/banner_model.dart';

class BannersRepo {
  final Dio dio;

  BannersRepo({required this.dio});

  Future<List<BannerModel>> getBanners(String locale) async {
    try {
      final response = await dio.get(
        "${EndPoints.baseUrl}${EndPoints.banners}",
        options: Options(
          headers: {"Accept": "application/json", "Accept-Language": locale},
        ),
      );

      if (response.data == null) {
        throw ServerExceptions(
          errorModel: ErrorModel(message: "Empty response from server"),
        );
      }

      final bannersResponse = BannersResponse.fromJson(response.data);
      return bannersResponse.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerExceptions(
        errorModel: ErrorModel(message: "Something went wrong: $e"),
      );
    }
  }
}
