import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is UserSuccess) {
          final user = state.user;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage:
                          user.image != null
                              ? NetworkImage(user.image!)
                              : const AssetImage(
                                    'assets/images/0260ba5cc140e59e77706f147401bc2e1f26f094.png',
                                  )
                                  as ImageProvider,
                    ),
                    // Container(
                    //   width: 28.w,
                    //   height: 28.w,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     shape: BoxShape.circle,
                    //     border: Border.all(color: AppTheme.gray1010, width: 2),
                    //   ),
                    //   padding: EdgeInsets.all(4.r),
                    //   child: const Icon(
                    //     Icons.camera_alt,
                    //     size: 16,
                    //     color: AppTheme.gray2,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 4.h),
                      // Text(
                      //   user.email,
                      //   style: Theme.of(
                      //     context,
                      //   ).textTheme.titleSmall!.copyWith(color: AppTheme.gray2),
                      // ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => context.push('/EditProfile'),
                  child: Column(
                    children: [
                      Icon(
                        Icons.mode_edit_outline_outlined,
                        color: AppTheme.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        translate.editProfile,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppTheme.primary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserFailure) {
          return Center(child: Text("Error: ${state.error}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
