import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/user_profile_tab/view/widgets/infoo.dart';
import 'package:marakiib_app/features/user_profile_tab/view/widgets/section_item.dart';

import '../../../../core/widgets/custom_button.dart';
import 'info_user.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoUserWrapper(),

            const SizedBox(height: 16),

            Text(
              translate.general,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),

            SectionItem(
              text: translate.favoriteCars,
              icon: Icons.favorite_border,
              onTap: () {
                context.push(AppRoutes.FavoriteCarScreen);
              },
            ),
            // SectionItem(
            //   text: 'Previous Rant',
            //   icon: Icons.history,
            //   onTap: () {
            //     context.push(AppRoutes.HistoryCarRentScreen);
            //   },
            // ),
            SectionItem(
              text: translate.eWallet,
              icon: Icons.account_balance_wallet_outlined,
              onTap: () {
                context.push('/WalletScreen');
              },
            ),
            SizedBox(height: 16.h),
            Text(
              translate.helpSupport,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            SectionItem(
              text: translate.languages,
              icon: Icons.language,
              onTap: () {
                context.push('/ChooseLanguageScreen1');
              },
            ),
            // const SectionItem(
            //   text: 'Invite Friends',
            //   icon: Icons.person_add_alt,
            // ),
            SectionItem(
              onTap: () {
                context.push('/PrivacyScreen');
              },
              text: translate.privacyPolicy,
              icon: Icons.privacy_tip_outlined,
            ),
            SectionItem(
              text: translate.aboutUs,
              icon: Icons.info,
              onTap: () {
                context.push('/AboutUsScreen');
              },
            ),
            SectionItem(
              text: translate.helpSupport,
              icon: Icons.headphones,
              onTap: () {
                context.push('/HelpSupport');
              },
            ),
            SectionItem(
              text: translate.logOut,
              icon: Icons.logout,
              onTap: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  final translate = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10.h),
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppTheme.primary,
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  translate.logoutDialogTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 12.h),
                Text(
                  translate.logoutDialogContent,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: MyCustomButton(
                        radius: 6.r,
                        text: translate.logOut,
                        borderColor: AppTheme.gray1011,
                        color: AppTheme.gray1011,
                        textColor: AppTheme.black,
                        voidCallback: () async {
                          await CacheHelper.remove("token");
                          await CacheHelper.remove("role");
                          print("🗑️ Token and Role removed successfully!");

                          context.go('/');
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: MyCustomButton(
                        radius: 6.r,
                        text: translate.cancelButton,
                        color: AppTheme.primary,
                        textColor: Colors.white,
                        borderColor: Colors.red,
                        voidCallback: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );
}
