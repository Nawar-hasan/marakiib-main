import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/favourit_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/is_favorite_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/is_favorite_state.dart';
import '../../view_model/cubit/favourit_state.dart';

class CarDetailsHeader extends StatelessWidget {
  final int carId;

  const CarDetailsHeader({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w).copyWith(top: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.of(context).pop(),
          ),


          BlocBuilder<IsFavouriteCubit, IsFavouriteState>(
            builder: (context, state) {
              print('🔵 Current State: $state');

              if (state is IsFavouriteLoading) {
                return SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
              }

              // الحالة الافتراضية
              bool isFav = false;

              if (state is IsFavouriteLoaded) {
                print('🟢 IsFav: ${state.isFavorite}, CarId: ${state.carId}, Current CarId: $carId');
                if (state.carId == carId) {
                  isFav = state.isFavorite;
                }
              }

              print('🎯 Final isFav value: $isFav');

              return CustomIconButton(
                icon: isFav ? Icons.favorite : Icons.favorite_border,
                iconColor: isFav ? Colors.red : Colors.grey,
                onTap: () async {
                  print('❤️ Clicked! Current state: $isFav');

                  context.read<IsFavouriteCubit>().updateLocalState(
                    !isFav,
                    carId,
                  );

                  try {
                    await context.read<FavouriteCubit>().toggleFavourite(
                      carId: carId,
                    );


                    await context.read<IsFavouriteCubit>().getIsFavourite(
                      carId,
                    );
                  } catch (e) {
                    context.read<IsFavouriteCubit>().updateLocalState(
                      isFav,
                      carId,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('فشل في تحديث المفضلة: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
