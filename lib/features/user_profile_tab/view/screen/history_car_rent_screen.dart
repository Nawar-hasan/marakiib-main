import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
import 'package:marakiib_app/features/user_home/data/models/recommended_car_model.dart';
import 'package:marakiib_app/features/user_home/view/widgets/recomendation_car_card.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class HistoryCarRentScreen extends StatelessWidget {
  // final List<RecommendationCarModel> recommendationCars = [];
  HistoryCarRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          translate.previousRent,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: CustomIconButton(
          icon: Icons.arrow_back,
          onTap: () {
            context.pop();
          },
          backgroundColor: Colors.transparent,
          boxShadow: [BoxShadow(color: Colors.transparent)],
        ),
        backgroundColor: AppTheme.gray1,
      ),
      // body: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: 0.72,
      //   ),
      //   itemBuilder:
      //       (context, index) => RecomendationCarCard(
      //         car: recommendationCars[index],
      //         onRent: () {},
      //       ),
      //   itemCount: recommendationCars.length,
      // ),
    );
  }
}
