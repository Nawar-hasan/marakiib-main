import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import '../../../../core/cash/shared.dart';
import '../view/data/login_model.dart';
import '../view/data/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(LoginModel login) async {
    emit(LoginLoading());
    try {
      final response = await repository.loginUser(login);

      if (response.data["user"] != null) {
        final userData = response.data["user"];
        final token = response.data["access_token"];
        final role = response.data["user"]["role"];

        // 🟢 حفظ البيانات
        await CacheHelper.setString("token", token);
        await CacheHelper.setString("role", role.toString());

        // 🟢 اطبع القيم لو اتسيفت
        final savedToken = CacheHelper.getString("token");
        final savedRole = CacheHelper.getString("role");

        if (savedToken != null && savedRole != null) {
          print("✅ Token Saved: $savedToken");
          print("✅ Role Saved: $savedRole");
          await sendFcmToken(savedToken);

        } else {
          print("⚠️ Saving failed!");
        }

        emit(LoginSuccess(
          message: response.data["message"] ?? "Login success",
          userData: userData,
          token: token,
        ));
      } else {
        emit(LoginFailure("Invalid email or password"));
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        emit(LoginFailure("Invalid email or password"));
      } else {
        emit(LoginFailure(e.toString()));
      }
    }
  }
  Future<bool> checkSubscriptionStatus(String token) async {
    try {
      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.get(
        '${EndPoints.baseUrl}${EndPoints.subscriptionsStatus}',
      );

      return response.data["has_active_subscription"] == true;
    } catch (e) {
      print("⚠️ Error checking subscription: $e");
      return false;
    }
  }

    Future<void> sendFcmToken(String token) async {
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          final dio = Dio();
          dio.options.headers["Authorization"] = "Bearer $token";
          await dio.post(
            '${EndPoints.baseUrl}${EndPoints.sendFcmToken}',
            data: {
              "fcm_token": fcmToken,
              "platform": "flutter",
            },
          );
          print("✅ FCM token sent successfully: $fcmToken");
        }
      } catch (e) {
        print("⚠️ Failed to send FCM token: $e");
      }
    }

}
