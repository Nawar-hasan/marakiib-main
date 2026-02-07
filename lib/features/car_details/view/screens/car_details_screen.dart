import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/routing/app_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/car_details/data/repository/car_details_repo.dart';
import 'package:marakiib_app/features/car_details/data/repository/favourit_repo.dart';
import 'package:marakiib_app/features/car_details/data/repository/new_chat_repo.dart';
import 'package:marakiib_app/features/car_details/view/widgets/car_details_info.dart';
import 'package:marakiib_app/features/car_details/view/widgets/car_features_grid.dart';
import 'package:marakiib_app/features/car_details/view/widgets/car_image_slider.dart';
import 'package:marakiib_app/features/car_details/view/widgets/car_location.dart';
import 'package:marakiib_app/features/car_details/view/widgets/car_map.dart';
import 'package:marakiib_app/features/car_details/view/widgets/image_indicator.dart';
import 'package:marakiib_app/features/car_details/view/widgets/image_thumbnails.dart';
import 'package:marakiib_app/features/car_details/view/widgets/price_panar.dart';
import 'package:marakiib_app/features/car_details/view/widgets/reviews_list.dart';
import 'package:marakiib_app/features/car_details/view/widgets/user_card.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/car_details_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/car_details_state.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/favourit_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/new_chat_cubit.dart';
import 'package:marakiib_app/features/car_details/view_model/cubit/new_chat_state.dart';
import 'package:marakiib_app/features/chat/view/screens/chat_screen.dart';
import 'package:marakiib_app/features/vendor_car_details/view/widgets/commissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import '../../view_model/cubit/is_favorite_cubit.dart';
import '../widgets/car_details_header.dart';

class CarDetailsScreen extends StatefulWidget {
  final int Id;

  const CarDetailsScreen({super.key, required this.Id});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final CarouselSliderController _pageController = CarouselSliderController();
  int _currentIndex = 0;

  double userLatitude = 0.0;
  double userLongitude = 0.0;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userLatitude = prefs.getDouble("user_lat") ?? 0.0;
      userLongitude = prefs.getDouble("user_lng") ?? 0.0;
    });
  }

  void _onImageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _jumpToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _onImageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => CarDetailsCubit(carDetailsRepo: CarDetailsRepo(dio: Dio()))
                ..getCarDetails(
                  carId: widget.Id,
                  locale: Localizations.localeOf(context).languageCode,
                ),
        ),
        BlocProvider(
          create:
              (_) => IsFavouriteCubit(dio: Dio())..getIsFavourite(widget.Id),
        ),
        BlocProvider(
          create: (_) => NewChatCubit(newChatRepo: NewChatRepo(dio: Dio())),
        ),
        BlocProvider(
          create:
              (_) => FavouriteCubit(favouriteRepo: FavouriteRepo(dio: Dio())),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: BlocConsumer<CarDetailsCubit, CarDetailsState>(
            listener: (context, state) {
              if (state is CarDetailsError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is CarDetailsLoading) {
                return const LoadingIndicator();
              } else if (state is CarDetailsLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CarDetailsHeader(carId: state.carDetails.id),
                            CarImageSlider(
                              images: state.carDetails.extraImages,
                              controller: _pageController,
                              onChanged: _onImageChanged,
                            ),
                            SizedBox(height: 10.h),
                            ImageIndicator(
                              count: state.carDetails.extraImages.length,
                              currentIndex: _currentIndex,
                              onDotClick: _jumpToPage,
                            ),
                            SizedBox(height: 16.h),
                            ImageThumbnails(
                              images: state.carDetails.extraImages,
                              currentIndex: _currentIndex,
                              onTap: _jumpToPage,
                            ),
                            SizedBox(height: 50.h),
                            CarDetailsInfo(
                              name: state.carDetails.name,
                              description: state.carDetails.description,
                              isActive: state.carDetails.isActive,
                              isOffice: state.carDetails.isOffice,
                            ),
                            Divider(
                              height: 32.h,
                              thickness: 1,
                              color: AppTheme.gray400,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            BlocConsumer<NewChatCubit, NewChatState>(
                              listener: (context, chatState) {
                                if (chatState is NewChatSuccess) {
                                  context.push(
                                    AppRoutes.ChatScreen,
                                    extra: ChaTData(
                                      name: chatState.conversation.renterName,
                                      id: chatState.conversation.id,
                                      image:
                                          state.carDetails.user.avatar ??
                                          "https://via.placeholder.com/150",
                                    ),
                                  );
                                } else if (chatState is NewChatFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(chatState.error)),
                                  );
                                }
                              },
                              builder: (context, chatState) {
                                final isLoading = chatState is NewChatLoading;
                                final conversationId =
                                    chatState is NewChatSuccess
                                        ? chatState.conversation.id
                                        : null;

                                return UserCard(
                                  name: state.carDetails.user.name,
                                  imageUrl:
                                      state.carDetails.user.avatar ??
                                      'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                  userid:
                                      conversationId ??
                                      state.carDetails.user.id,
                                  isLoading: isLoading,
                                  onChatPressed: () {
                                    context.read<NewChatCubit>().createChat(
                                      receiverId: state.carDetails.user.id,
                                    );
                                  },
                                );
                              },
                            ),

                            // Divider(
                            //   height: 32.h,
                            //   thickness: 1,
                            //   color: AppTheme.gray400,
                            //   indent: 16.w,
                            //   endIndent: 16.w,
                            // ),
                            // // إضافة ويدجت التوفر
                            // CarAvailabilityWidget(
                            //   availabilityStart: state.carDetails.availabilityStart,
                            //   availabilityEnd: state.carDetails.availabilityEnd,
                            // ),
                            Divider(
                              height: 32.h,
                              thickness: 1,
                              color: AppTheme.gray400,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CarLocationText(
                                    latitude: state.carDetails.latitude,
                                    longitude: state.carDetails.longitude,
                                  ),
                                  // Pickup Delivery Price (if available)
                                  if (state.carDetails.pickupDeliveryPrice !=
                                      null) ...[
                                    Divider(
                                      height: 32.h,
                                      thickness: 1,
                                      color: AppTheme.gray400,
                                      indent: 16.w,
                                      endIndent: 16.w,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_shipping,
                                          color: AppTheme.primary,
                                          size: 20,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '${AppLocalizations.of(context)!.pickupAndDelivery}: ${state.carDetails.pickupDeliveryPrice} ${AppLocalizations.of(context)!.currency}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  // Plate Type (if available)
                                  if (state.carDetails.plateType != null) ...[
                                    SizedBox(height: 12.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.credit_card,
                                          color: AppTheme.primary,
                                          size: 20,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '${AppLocalizations.of(context)!.plateType}: ${state.carDetails.plateType}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            Divider(
                              height: 32.h,
                              thickness: 1,
                              color: AppTheme.gray400,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            CommissionDescriptionWidget(
                              appliesTo: 'buyer',
                              plateType: state.carDetails.plateType,
                            ),
                            Divider(
                              height: 32.h,
                              thickness: 1,
                              color: AppTheme.gray400,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            CarFeaturesGrid(
                              features: state.carDetails.features,
                            ),
                            ReviewsList(carDetailsModel: state.carDetails),
                            Divider(
                              height: 32.h,
                              thickness: 1,
                              color: AppTheme.gray400,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),
                            CarMapGoogle(
                              userLat: userLatitude,
                              userLng: userLongitude,
                              ownerLat:
                                  double.tryParse(state.carDetails.latitude) ??
                                  0.0,
                              ownerLng:
                                  double.tryParse(state.carDetails.longitude) ??
                                  0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    PricePanar(
                      price: state.carDetails.rentalPrice,
                      carId: state.carDetails.id,
                      pickupDelivery: state.carDetails.pickupDelivery,
                      pickupDeliveryPrice: state.carDetails.pickupDeliveryPrice,
                      commissionValue: state.carDetails.commissionValue,
                      commissionType: state.carDetails.commissionType,
                      plateType: state.carDetails.plateType,
                    ),
                  ],
                );
              } else if (state is CarDetailsError) {
                return Center(
                  child: Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
