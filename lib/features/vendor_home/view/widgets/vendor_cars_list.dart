import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/vendor_home/data/financing_model.dart';
import 'package:marakiib_app/features/vendor_home/data/financing_repo.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_service.dart';
import 'package:marakiib_app/features/vendor_home/view/widgets/show_financing_dialog.dart';
import 'package:marakiib_app/features/vendor_home/view/widgets/vendor_car_card.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_plans_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_state.dart';
import 'package:marakiib_app/features/vendor_home/view_model/my_cars_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/my_cars_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:dio/dio.dart';

class VendorCarsListScreen extends StatelessWidget {
  const VendorCarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MyCarCubit(MyCarService(Dio()))..fetchMyCars(),
        ),
        BlocProvider(
          create: (_) => FinancingCubit(FinancingRepository()),
        ),
        BlocProvider(
          create: (_) => FinancingPlansCubit()..getFinancingPlans(),
        ),
      ],
      child: const VendorCarsList(),
    );
  }
}

class VendorCarsList extends StatelessWidget {
  const VendorCarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FinancingCubit, FinancingState>(
      listener: (context, state) {
        if (state is FinancingSuccess) {
          Navigator.pop(context); // إغلاق الـ dialog إذا كان مفتوح
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(message: 'تم إرسال الطلب بنجاح'),
          );
        } else if (state is FinancingError) {
          Navigator.pop(context); // إغلاق loading
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.error),
          );
        }
      },
      builder: (context, financeState) {
        return BlocBuilder<MyCarCubit, MyCarState>(
          builder: (context, state) {
            if (state is MyCarLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: LoadingIndicator()),
              );
            }

            if (state is MyCarSuccess) {
              if (state.cars.isEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 200.h),
                      Lottie.asset('assets/images/Empty Box.json', height: 200.h),
                      const Text('لا توجد سيارات'),
                    ],
                  ),
                );
              }

              return SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 5.h,
                  childAspectRatio: 0.54,
                ),
                itemCount: state.cars.length,
                itemBuilder: (context, index) {
                  final car = state.cars[index];
                  return VendorCarCard(
                    car: car,
                    onRent: () {
                      showFinancingDialog(context: context, car: car);
                    },
                  );
                },
              );
            }

            if (state is MyCarFailure) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(state.error, style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                ),
              );
            }

            return const SliverToBoxAdapter(child: Center(child: Text('جاري التحميل...')));
          },
        );
      },
    );
  }
}
