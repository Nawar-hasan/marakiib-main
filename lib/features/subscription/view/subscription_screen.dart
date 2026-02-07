import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import '../../../../core/themeing/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../data/subscription_model.dart';
import '../view_model/subscription_cubit.dart';
import '../view_model/subscription_state.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubscriptionCubit(Dio()).._initFetch(),
      child: Scaffold(
        backgroundColor: AppTheme.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.subscriptionTitle),
          backgroundColor: AppTheme.white,
        ),
        body: BlocListener<SubscriptionCubit, SubscriptionState>(
          listener: (context, state) {
            if (state is SubscriptionPurchased) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(message: state.message),
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                context.go(AppRoutes.VendorNavBarView);
              });
            } else if (state is SubscriptionError) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message:
                      AppLocalizations.of(context)!.errorInsufficientBalance,
                ),
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                context.pop();
              });
            }
          },
          child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
            builder: (context, state) {
              if (state is SubscriptionLoading) {
                return const Center(child: LoadingIndicator());
              } else if (state is SubscriptionLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: state.plans.length,
                  itemBuilder: (context, index) {
                    final plan = state.plans[index];

                    final colors = [
                      AppTheme.primary,
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                    ];
                    final bgColor = colors[index % colors.length];

                    final isLoading = state is SubscriptionLoading;

                    return Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.planName,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',

                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "${plan.price}",
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',

                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.white,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.currency, // "دينار" أو "JD" حسب اللغة
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',

                                    fontSize: 16,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "${plan.duration}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.day, // "يوم" أو "day" حسب اللغة
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',

                                    fontSize: 14,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (plan.maxCars > 0)
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.carsAllowed(plan.maxCars),
                                style: const TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 14,
                                ),
                              ),
                            if (plan.description != null)
                              Text(
                                plan.description!,
                                style: const TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 14,
                                ),
                              ),
                            const Spacer(),
                            MyCustomButton(
                              text:
                                  isLoading
                                      ? AppLocalizations.of(context)!.loading
                                      : AppLocalizations.of(
                                        context,
                                      )!.choosePlan,
                              voidCallback: () {
                                if (!isLoading) {
                                  () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token =
                                        prefs.getString("token") ?? "";
                                    context
                                        .read<SubscriptionCubit>()
                                        .purchasePlan(token, plan.id);
                                  }();
                                }
                              },
                              color: AppTheme.white,
                              textColor: AppTheme.primary,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is SubscriptionError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

extension on SubscriptionCubit {
  void _initFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";
    fetchPlans(token);
  }
}
