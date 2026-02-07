import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_profile_tab/view/widgets/favourites_card.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/get_favourites_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/get_favourites_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class FavoriteCarScreen extends StatelessWidget {
  FavoriteCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => FavouritesCubit()..fetchFavourites(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            translate.favorite,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: CustomIconButton(
            icon: Icons.arrow_back,
            onTap: () => context.pop(),
            backgroundColor: Colors.transparent,
            boxShadow: [BoxShadow(color: Colors.transparent)],
          ),
          backgroundColor: AppTheme.gray1,
        ),
        body: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return Center(child: LoadingIndicator());
            } else if (state is FavouritesSuccess) {
              final favourites = state.favourites;
              if (favourites.isEmpty) {
                return Center(child: Text(translate.noFavouritesFound));
              }
              return GridView.builder(
                padding: EdgeInsets.all(8.sp),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                ),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final car = favourites[index];
                  return FavouriteCarCard(car: car, onRent: () {});
                },
              );
            } else if (state is FavouritesFailure) {
              return Center(child: Text(state.error));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
