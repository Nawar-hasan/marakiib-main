import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/search_home/data/repository/search_repo.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_cubit.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_state.dart';
import 'package:marakiib_app/features/user_home/view/widgets/banner_carousel.dart';
import 'package:marakiib_app/features/user_home/view/widgets/car_available_list.dart';
import 'package:marakiib_app/features/user_home/view/widgets/financed_car_list.dart';
import 'package:marakiib_app/features/user_home/view/widgets/popular_car_list.dart';
import 'package:marakiib_app/features/user_home/view/widgets/recommendation_car_list.dart';
import 'package:marakiib_app/features/user_home/view/widgets/search_location_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose(); // ✅ الحل هنا
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => SearchCubit(CarSearchRepo(dio: Dio())),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ================= SEARCH HEADER =================
              SearchHeader(controller: _searchController),

              /// ================= SEARCH RESULTS =================
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccess &&
                      _searchController.text.isNotEmpty) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cars.length,
                        itemBuilder: (context, index) {
                          final car = state.cars[index];

                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    car.mainImage ??
                                    'https://via.placeholder.com/40',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                placeholder:
                                    (_, __) => const LoadingIndicator(),
                                errorWidget:
                                    (_, __, ___) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                              ),
                            ),
                            title: Text(car.name ?? car.model!),
                            subtitle: Text(
                              "${car.rentalPrice} / ${translate.day}",
                            ),
                            onTap: () {
                              _searchController.text = car.name ?? car.model!;
                              FocusScope.of(context).unfocus();

                              context.push(
                                AppRoutes.CarDetailsScreen,
                                extra: car.id,
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              /// ================= MAIN CONTENT =================
              BannerCarousel(),
              FinancedCarList(),
              PopularCarList(),
              RecommendationCarList(),
              CarsAvailableList(),
            ],
          ),
        ),
      ),
    );
  }
}
