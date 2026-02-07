import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/features/user_booking_tab/view/screens/booking_tab_screen.dart';
import 'package:marakiib_app/features/user_home/view/screens/home_screen.dart';
import 'package:marakiib_app/features/messages/view/screens/messages_screen.dart';
import 'package:marakiib_app/features/user_notifications/view/screens/notification_screen.dart';
import 'package:marakiib_app/features/user_profile_tab/view/screen/profile_screen.dart';
import 'package:marakiib_app/features/user_navbar/view/widgets/nav_icon.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import '../../../user_notifications/view_model/get_notification_cubit.dart';
import '../../../user_notifications/view_model/get_notification_state.dart';

class UserNavBarView extends StatefulWidget {
  const UserNavBarView({super.key});

  @override
  State<UserNavBarView> createState() => _UserNavBarViewState();
}

class _UserNavBarViewState extends State<UserNavBarView> {
  int currentIndex = 2;

  final List<Widget> screens = [
    MessagesScreen(),
    BookingTabScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  Future<bool> _onWillPop() async {
    if (currentIndex != 2) {
      setState(() {
        currentIndex = 2;
      });
      return false;
    } else {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) {
          final translate = AppLocalizations.of(context)!;
          return AlertDialog(
            backgroundColor: AppTheme.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            title: Text(
              translate.exitAppQuestion,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.black,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            actionsPadding: EdgeInsets.only(
              bottom: 16.h,
              right: 16.w,
              left: 16.w,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCustomButton(
                    text: translate.no,
                    voidCallback: () => Navigator.of(context).pop(false),
                    width: 120.w,
                    height: 40.h,
                    radius: 8.r,
                    fontSize: 14.sp,
                    color: AppTheme.gray400,
                    textColor: AppTheme.white,
                    borderColor: AppTheme.gray400,
                  ),
                  MyCustomButton(
                    text: translate.yes,
                    voidCallback: () => Navigator.of(context).pop(true),
                    width: 120.w,
                    height: 40.h,
                    radius: 8.r,
                    fontSize: 14.sp,
                    color: AppTheme.primary,
                    textColor: AppTheme.white,
                    borderColor: AppTheme.primary,
                  ),
                ],
              ),
            ],
          );
        },
      );
      return shouldExit ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit()..getUnreadCount(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int unreadCount = 0;
          if (state is NotificationSuccess) {
            unreadCount = state.notifications.where((n) => !n.isRead).length;
          }
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: screens[currentIndex],
              bottomNavigationBar: ConvexAppBar(
                initialActiveIndex: currentIndex,
                height: 57.h,
                backgroundColor: Colors.black,
                activeColor: AppTheme.primary,
                color: Colors.white,
                style: TabStyle.fixedCircle,
                items: [
                  TabItem(
                    icon: nav_Icon(
                      assetPath: 'assets/icons/message_icon.png',
                      isActive: currentIndex == 0,
                    ),
                    title: AppLocalizations.of(context)!.chats,
                  ),
                  TabItem(
                    icon: nav_Icon(
                      assetPath: 'assets/icons/road_icon.png',
                      isActive: currentIndex == 1,
                    ),
                    title: AppLocalizations.of(context)!.myBookings,
                  ),
                  TabItem(
                    icon: nav_Icon(
                      assetPath: 'assets/icons/eco_icon.png',
                      isActive: currentIndex == 2,
                      inactiveColor: AppTheme.black,
                      activeColor: AppTheme.white,
                    ),
                    title: 'Home',
                  ),
                  TabItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        nav_Icon(
                          assetPath: 'assets/icons/notification_icon.png',
                          isActive: currentIndex == 3,
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 20.w,
                                minHeight: 20.h,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount > 99 ? '99+' : '$unreadCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: AppLocalizations.of(context)!.alerts,
                  ),
                  TabItem(
                    icon: nav_Icon(
                      assetPath: 'assets/icons/person_icon.png',
                      isActive: currentIndex == 4,
                    ),
                    title: AppLocalizations.of(context)!.profile,
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                  // لو فتح صفحة الإشعارات نصفر العداد
                  if (index == 3) {
                    context.read<NotificationCubit>().getNotifications();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
