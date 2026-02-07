import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/notification/data/send_fcm_state.dart';

class SendFcmCubit extends Cubit<SendFcmState> {
  SendFcmCubit() : super(SendFcmInitial());

  Future<void> sendFcmToken() async {
    emit(SendFcmLoading());
    try {
      final String? token = CacheHelper.getString("token");
      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (token == null || fcmToken == null) {
        emit(SendFcmError("❌ مفيش بيانات كفاية لإرسال التوكن"));
        return;
      }

      final response = await Dio().post(
        'https://api.marakiib.com/api/device/token',
        data: {
          "fcm_token": fcmToken,
          "platform": "flutter",
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        emit(SendFcmSuccess());
        print("✅ FCM Token sent successfully");
      } else {
        emit(SendFcmError("⚠️ فشل إرسال FCM Token"));
      }
    } catch (e) {
      emit(SendFcmError("🚨 خطأ أثناء إرسال FCM Token: $e"));
    }
  }
}
