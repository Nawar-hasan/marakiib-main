import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_cubit.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_state.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate.searchResults),
        backgroundColor: AppTheme.white,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is SearchSuccess) {
            if (state.cars.isEmpty) {
              return Center(child: Text(translate.noResults));
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                final car = state.cars[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl:
                          car.mainImage ?? 'https://via.placeholder.com/40',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  title: Text(car.name ?? car.model!),
                  subtitle: Text("${car.rentalPrice} / ${translate.day}"),
                  onTap: () {
                    context.push(
                      AppRoutes.CarDetailsScreen,
                      extra: state.cars[index].id,
                    );
                  },
                );
              },
            );
          } else if (state is SearchError) {
            return Center(child: Text("❌ ${state.message}"));
          }
          return Center(child: Text(translate.searchOrSelectFilter));
        },
      ),
    );
  }
}
