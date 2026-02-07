import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/wallet_screen/data/wallet_repo.dart';
import 'package:marakiib_app/features/wallet_screen/view/screens/wallet_history_page.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_state.dart';
import '../../../../core/themeing/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final dio = Dio();
    final repository = WalletRepository(dio);

    return BlocProvider(
      create: (_) => WalletCubit(repository)..fetchWalletBalance(),
      child: Scaffold(
        backgroundColor: AppTheme.gray1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            local.myWallet,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.history, color: AppTheme.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoading) {
                    return _buildShimmerCard();
                  } else if (state is WalletSuccess) {
                    return _buildWalletCard(state.wallet, local);
                  } else if (state is WalletFailure) {
                    return _buildErrorCard(state.error);
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.add_circle_outline,
                      label: local.deposit,
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.secondaryPrimary],
                      ),
                      onTap: () {
                        context.push('/PaymentSend');
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.arrow_upward_rounded,
                      label: local.withdrawal,
                      gradient: LinearGradient(
                        colors: [AppTheme.secondaryPrimary, AppTheme.primary],
                      ),
                      onTap: () {
                        context.push('/WithdrawalMethodsScreen');
                      },
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              SizedBox(height: 32.h),
              Expanded(child: WalletHistoryPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(dynamic wallet, AppLocalizations local) {
    return Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppTheme.primary,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 24.w,
                top: 24.h,
                child: Container(
                  width: 45.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 30.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20.w,
                top: 20.h,
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.white.withOpacity(0.8),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-15.w, 0),
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 35.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.availableBalance,
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            color: AppTheme.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${wallet.balance}",
                              style: GoogleFonts.roboto(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.white,
                                height: 1,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Text(
                                'JOD',
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "WALLET CARD",
                          style: GoogleFonts.roboto(
                            fontSize: 11.sp,
                            color: AppTheme.white.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 24.sp,
                          color: AppTheme.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.red[50],
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[700], size: 32.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              error,
              style: GoogleFonts.cairo(fontSize: 14.sp, color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.white, size: 28.sp),
            SizedBox(height: 6.h),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 13.sp,
                color: AppTheme.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
