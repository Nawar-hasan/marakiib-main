import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/about_us/view/about_us_screen.dart';
import 'package:marakiib_app/features/auth/sign_up/view/screens/otp.dart';
import 'package:marakiib_app/features/auth/sign_up/view/widgets/complete_profile_view.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';
import 'package:marakiib_app/features/car_details/view/screens/car_details_screen.dart';
import 'package:marakiib_app/features/car_details/view/screens/car_reviews_screen.dart';
import 'package:marakiib_app/features/car_details/view/screens/image_view_screen.dart';
import 'package:marakiib_app/features/choose_language/view/screen/choose_language_screen1.dart';
import 'package:marakiib_app/features/messages/data/models/conversations_model.dart';
import 'package:marakiib_app/features/privacy/view/privacy_screen.dart';
import 'package:marakiib_app/features/upload_car/view/screens/upload_car_screen.dart';
import 'package:marakiib_app/features/user_home/view/screens/map_screen.dart';
import 'package:marakiib_app/features/chat/view/screens/chat_screen.dart';
import 'package:marakiib_app/features/user_home/view/widgets/fliter.dart';
import 'package:marakiib_app/features/user_home/view/widgets/search_screen.dart';
import 'package:marakiib_app/features/user_profile_tab/view/screen/favorite_car_screen.dart';
import 'package:marakiib_app/features/user_profile_tab/view/screen/history_car_rent_screen.dart';
import 'package:marakiib_app/features/user_profile_tab/view/widgets/profile.dart';
import 'package:marakiib_app/features/vendor_car_details/view/screens/update_car.dart';
import 'package:marakiib_app/features/vendor_car_details/view/screens/vendor_car_details_screen.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/features/vendor_navbar/view/screens/vendor_navbar.dart';
import 'package:marakiib_app/features/wallet_screen/view/screens/payment_resved.dart';
import 'package:marakiib_app/features/wallet_screen/view/screens/payment_send.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/payment_send_cubit.dart';
import '../../features/auth/forget_password/view/screen/forget_screen_screen.dart';
import '../../features/auth/forget_password/view/screen/pin_screen.dart';
import '../../features/auth/forget_password/view/screen/set_new_password.dart';
import '../../features/auth/login/view/screen/login_screen.dart';
import '../../features/auth/sign_up/view/data/data_source/verify_otp_repository.dart';
import '../../features/auth/sign_up/view/screens/sign_up_screen.dart';
import '../../features/auth/sign_up/view/screens/sign_up_vendor.dart';
import '../../features/auth/sign_up/view_model/verify_otp_cubit.dart';
import '../../features/booking_screen/view/screens/booking_details.dart';
import '../../features/choose_language/view/screen/choose_language_screen.dart';
import '../../features/on_board/presentation/views/on_board_screen.dart';
import '../../features/subscription/view/subscription_screen.dart';
import '../../features/user_profile_tab/view/screen/profile_screen.dart';
import '../../features/user_profile_tab/view/widgets/edit_profile.dart';
import '../../features/user_profile_tab/view/widgets/help_support.dart';
import '../../features/splash/view/screen/splash_screen.dart';
import 'package:marakiib_app/features/user_navbar/view/screens/user_navbar.dart';

import '../../features/vendor_home/view/screens/not_sub.dart';
import '../../features/wallet_screen/view/screens/wallet_screen.dart';
import '../../features/vendor_financings/view/screens/my_financings_screen.dart';
import '../../features/vendor_subscription/view/screens/my_subscription_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRoutes {
  static const String splash = '/';
  static const String onBoard = '/OnBoardViewBody';
  static const String chooseLanguage = '/ChooseLanguageScreen';
  static const String login = '/LoginScreen';
  static const String userNavBar = '/userNavBar';
  static const String CarDetailsScreen = '/CarDetailsScreen';
  static const String MapScreen = '/MapScreen';
  static const String ImageViewScreen = '/ImageViewScreen';
  static const String CarReviewsScreen = '/CarReviewsScreen';
  static const String ChatScreen = '/ChatScreen';
  static const String FavoriteCarScreen = '/FavoriteCarScreen';
  static const String HistoryCarRentScreen = '/HistoryCarRentScreen';
  static const String SignUpVendor = '/SignUpVendor';
  // static const String WalletScreen = '/WalletScreen';
  static const String searchResults = "/search-results";
  static const String completeProfileView = '/completeProfile'; // 👈 جديد

  static const String VendorNavBarView = '/VendorNavBarView';
  static const String UploadCarScreen = '/UploadCarScreen';
  static const String VendorCarDetailsScreen = '/VendorCarDetailsScreen';
  static const String EditCarScreen = '/edit-car';
}

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(
        path: '/OnBoardViewBody',
        builder: (context, state) => OnBoardViewBody(),
      ),
      GoRoute(
        path: '/ChooseLanguageScreen',
        builder: (context, state) => ChooseLanguageScreen(),
      ),
      GoRoute(
        path: '/WalletScreen',
        builder: (context, state) => WalletScreen(),
      ),
      GoRoute(
        path: '/MyFinancingsScreen',
        builder: (context, state) => MyFinancingsScreen(),
      ),
      GoRoute(
        path: '/MySubscriptionScreen',
        builder: (context, state) => MySubscriptionScreen(),
      ),
      GoRoute(
        path: '/SearchFilterPage',
        builder: (context, state) => SearchFilterPage(),
      ),
      GoRoute(
        path: AppRoutes.searchResults,
        builder: (context, state) {
          final cars = state.extra as List<dynamic>;
          return SearchResultsScreen(cars: cars);
        },
      ),
      GoRoute(
        path: AppRoutes.completeProfileView,
        builder: (context, state) => const CompleteProfileView(),
      ),

      GoRoute(
        path: '/ForgetPasswordScreen',
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: '/PaymentSend',
        builder: (context, state) {
          return BlocProvider(
            create:
                (context) => PaymentCubit(
                  Dio(
                    BaseOptions(
                      baseUrl: EndPoints.baseUrl,
                      receiveDataWhenStatusError: true,
                      connectTimeout: const Duration(seconds: 20),
                      receiveTimeout: const Duration(seconds: 20),
                    ),
                  ),
                ),
            child: const PaymentScreen(),
          );
        },
      ),

      GoRoute(
        path: '/AboutUsScreen',
        builder: (context, state) => AboutUsScreen(),
      ),
      GoRoute(
        path: '/WithdrawalMethodsScreen',
        builder: (context, state) => WithdrawalPage(),
      ),
      GoRoute(
        path: '/PrivacyScreen',
        builder: (context, state) => PrivacyScreen(),
      ),
      GoRoute(
        path: '/ChooseLanguageScreen1',
        builder: (context, state) => ChooseLanguageScreen1(),
      ),
      GoRoute(path: '/LoginScreen', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/SignUpScreen',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/ProfileScreen',
        builder: (context, state) => ProfileScreen(),
      ),

      GoRoute(
        path: '/EditProfile',
        builder: (context, state) => EditProfilePage(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) {
          final data =
              state.extra as Map<String, String>; // <- هنا Map بدل String
          return ResetOtpScreen(data: data); // تمرير الـ Map للشاشة
        },
      ),

      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>; // ← هنا الصح

          final email = data['email'];
          final otpMethod = data['otp_method'];

          return BlocProvider(
            create: (context) => VerifyOtpCubit(VerifyOtpRepository(Dio())),
            child: Otp(email: email, otpMethod: otpMethod),
          );
        },
      ),

      GoRoute(
        path: '/BookingDetailsScreen',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return BookingDetailsScreen(
            carId: data['carId'] as int,
            rentalPrice: data['rentalPrice'] as String,
            pickupDelivery: (data['pickupDelivery'] as int?) ?? 0,
            pickupDeliveryPrice: data['pickupDeliveryPrice'] as String?,
            commissionValue: data['commissionValue'] as String?,
            commissionType: data['commissionType'] as String?,
            plateType: data['plateType'] as String?,
          );
        },
      ),

      GoRoute(
        path: '/ResetPasswordScreen',
        builder: (context, state) {
          final data = state.extra as Map<String, String>;
          return ResetPasswordScreen(
            email: data['email']!,
            otpCode: data['otp']!,
          );
        },
      ),
      GoRoute(path: '/HelpSupport', builder: (context, state) => HelpSupport()),
      GoRoute(path: '/NotSub', builder: (context, state) => NotSub()),
      GoRoute(
        path: '/SubscriptionScreen',
        builder: (context, state) => SubscriptionScreen(),
      ),

      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onBoard,
        builder: (context, state) => OnBoardViewBody(),
      ),
      GoRoute(
        path: AppRoutes.SignUpVendor,
        builder: (context, state) => SignUpVendor(),
      ),
      GoRoute(
        path: AppRoutes.chooseLanguage,
        builder: (context, state) => ChooseLanguageScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.userNavBar,
        builder: (context, state) => UserNavBarView(),
      ),
      GoRoute(
        path: AppRoutes.MapScreen,
        builder: (context, state) => MapScreen(),
      ),
      GoRoute(
        path: AppRoutes.CarDetailsScreen,
        builder: (context, state) {
          final int id = state.extra as int;
          return CarDetailsScreen(Id: id);
        },
      ),
      GoRoute(
        path: AppRoutes.ImageViewScreen,
        builder: (context, state) {
          final String image = state.extra as String;
          return ImageViewScreen(image: image);
        },
      ),
      GoRoute(
        path: AppRoutes.CarReviewsScreen,
        builder: (context, state) {
          final CarDetailsModel carDetailsModel =
              state.extra as CarDetailsModel;
          return CarReviewsScreen(carDetailsModel: carDetailsModel);
        },
      ),
      GoRoute(
        path: AppRoutes.ChatScreen,
        builder: (context, state) {
          final ChaTData chaTData = state.extra as ChaTData;

          return ChatScreen(chaTData: chaTData);
        },
      ),
      GoRoute(
        path: AppRoutes.FavoriteCarScreen,
        builder: (context, state) => FavoriteCarScreen(),
      ),
      GoRoute(
        path: AppRoutes.HistoryCarRentScreen,
        builder: (context, state) => HistoryCarRentScreen(),
      ),
      GoRoute(
        path: AppRoutes.VendorNavBarView,
        builder: (context, state) => VendorNavBarView(),
      ),
      GoRoute(
        path: AppRoutes.UploadCarScreen,
        builder: (context, state) => UploadCarScreen(),
      ),
      GoRoute(
        path: AppRoutes.EditCarScreen,
        builder: (context, state) {
          final car = state.extra as VendorCarModel?;
          if (car == null) {
            return const Scaffold(
              body: Center(child: Text('No car data provided')),
            );
          }
          return EditCarScreen(car: car);
        },
      ),
      GoRoute(
        path: AppRoutes.VendorCarDetailsScreen,
        builder: (context, state) {
          final car = state.extra as VendorCarModel;
          return VendorCarDetailsScreen(car: car);
        },
      ),
    ],
  );
}
