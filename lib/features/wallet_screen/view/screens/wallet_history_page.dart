import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_history__cubit.dart';
import 'package:marakiib_app/features/wallet_screen/view_model/wallet_history__state.dart';


class WalletHistoryPage extends StatelessWidget {
  const WalletHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => WalletHistoryCubit(Dio())..getHistory(),
      child: Scaffold(
        backgroundColor: AppTheme.gray1,

        // appBar: AppBar(title: Text(local.walletHistory)),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<WalletHistoryCubit, WalletHistoryState>(
            builder: (context, state) {
              if (state is WalletHistoryLoading) {
                return const Center(child: LoadingIndicator());
              } else if (state is WalletHistoryFailure) {
                return Center(child: Text("Error: ${state.error}"));
              } else if (state is WalletHistorySuccess) {
                final histories = state.histories;
                if (histories.isEmpty) {
                  return Center(child: Text(local.noHistory));
                }
                return ListView.separated(
                  itemCount: histories.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final item = histories[index];
                    final details = item.related.details.entries.map((e) => "${e.key}: ${e.value}").join(", ");

                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${local.amount}: ${item.amount}"),
                          Text("${local.status}: ${item.status}"),
                          Text("${local.description}: ${item.description}"),
                          Text("${local.details}: $details"),
                          if (item.related.adminNotes != null)
                            Text("${local.adminNotes}: ${item.related.adminNotes}"),
                        ],
                      ),
                    );

                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
