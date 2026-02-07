// vendor_navbar_view.dart
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/features/messages/view/screens/messages_screen.dart';
import 'package:marakiib_app/features/user_notifications/view/screens/notification_screen.dart';
import 'package:marakiib_app/features/user_profile_tab/view/screen/profile_screen_vendor.dart';
import 'package:marakiib_app/features/vendor_home/view/screens/vendor_home_screen.dart';
import 'package:marakiib_app/features/vendor_transactions/view/screens/transactions_screen.dart';
import 'package:marakiib_app/features/user_navbar/view/widgets/nav_icon.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import '../../../user_notifications/view_model/get_notification_cubit.dart';
import '../../../user_notifications/view_model/get_notification_state.dart';

class VendorNavBarView extends StatefulWidget {
  const VendorNavBarView({super.key});

  @override
  State<VendorNavBarView> createState() => _VendorNavBarViewState();
}

class _VendorNavBarViewState extends State<VendorNavBarView> {
  int currentIndex = 2;
  late NotificationCubit notificationCubit;

  final List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    notificationCubit = NotificationCubit()..getNotifications();
    screens.addAll([
      MessagesScreen(),
      TransactionsTabScreen(),
      VendorHomeScreen(),
      NotificationScreen(),
      ProfileScreenVendor(),
    ]);
  }

  @override
  void dispose() {
    notificationCubit.close();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (currentIndex != 2) {
      setState(() {
        currentIndex = 2;
      });
      return false;
    } else {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            'هل تريد الخروج من التطبيق؟',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.black,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          actionsPadding: EdgeInsets.only(bottom: 16.h, right: 16.w, left: 16.w),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyCustomButton(
                  text: 'لا',
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
                  text: 'نعم',
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
        ),
      );
      return shouldExit ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notificationCubit,
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int unreadCount = 0;
          if (state is NotificationSuccess) {
            unreadCount = state.notifications.where((n) => !n.isRead).length;
          }

          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: IndexedStack(
                index: currentIndex,
                children: screens,
              ),
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
                      assetPath: 'assets/icons/subscriptions.png',
                      isActive: currentIndex == 1,
                    ),
                    title: AppLocalizations.of(context)!.deals,
                  ),
                  TabItem(
                    icon: nav_Icon(
                      assetPath: 'assets/icons/eco_icon.png',
                      isActive: currentIndex == 2,
                      inactiveColor: AppTheme.black,
                      activeColor: AppTheme.white,
                    ),
                    title: AppLocalizations.of(context)!.home,
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
                  if (index == 3) {
                    notificationCubit.getNotifications();
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
