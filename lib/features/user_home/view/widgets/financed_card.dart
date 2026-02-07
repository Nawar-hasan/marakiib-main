import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_home/data/models/financed_car_model.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class FinancedCarCard extends StatefulWidget {
  final FinancedCarModel car;

  const FinancedCarCard({super.key, required this.car});

  @override
  State<FinancedCarCard> createState() => _FinancedCarCardState();
}

class _FinancedCarCardState extends State<FinancedCarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carData = widget.car.car;
    final planData = widget.car.plan;
    final translate = AppLocalizations.of(context)!;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          Future.delayed(const Duration(milliseconds: 100), () {
            context.push(
              '/CarDetailsScreen',
              extra: carData?.id ?? widget.car.id,
            );
          });
        },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          width: 223.w,
          height: 250.h,
          margin: EdgeInsets.all(12.sp).copyWith(right: 4),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              // BoxShadow(
              //   color: AppTheme.primary.withOpacity(0.12),
              //   blurRadius: 16,
              //   spreadRadius: 0,
              //   offset: const Offset(0, 8),
              // ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 8,
                spreadRadius: -4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Badge للتمويل
              // Badge للتمويل
              Positioned(
                top: 0,
                right:
                    Directionality.of(context) == TextDirection.ltr ? 0 : null,
                left:
                    Directionality.of(context) == TextDirection.rtl ? 0 : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(16.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection:
                        TextDirection.ltr, // يحافظ على ترتيب الايقونة والنص
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: AppTheme.white,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        translate.funder,
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم العربية
                    Text(
                      carData?.name ?? 'Unknown Car',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // صورة العربية مع تأثير
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  carData?.mainImage ??
                                  'https://via.placeholder.com/150',
                              height: 100.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    height: 100.h,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: LoadingIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    height: 100.h,
                                    color: Colors.grey.shade100,
                                    child: const Center(
                                      child: Icon(
                                        Icons.car_crash_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                            ),
                            // Overlay gradient خفيف للصورة
                            Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.03),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // السعر مع تصميم مميز
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              carData?.rentalPrice ??
                                  planData?.dailyPrice ??
                                  '0',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'JOD',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '/ ${translate.day ?? 'day'}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // زرار الحجز
                    Material(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(10.r),
                      elevation: 4,
                      shadowColor: AppTheme.primary.withOpacity(0.3),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          context.push(
                            '/BookingDetailsScreen',
                            extra: {
                              'carId': carData?.id ?? widget.car.carId,
                              'rentalPrice':
                                  carData?.rentalPrice ?? planData.dailyPrice,
                              'pickupDelivery':
                                  widget.car.pickupDelivery ??
                                  carData?.pickupDelivery ??
                                  0,
                              'pickupDeliveryPrice':
                                  widget.car.pickupDeliveryPrice ??
                                  carData?.pickupDeliveryPrice,
                              'commissionValue':
                                  widget.car.commissionValue ??
                                  carData?.commissionValue,
                              'commissionType':
                                  widget.car.commissionType ??
                                  carData?.commissionType,
                              'plateType':
                                  widget.car.plateType ??
                                  carData?.plateType ??
                                  planData.plateType,
                            },
                          );
                        },
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translate.rentNow,
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppTheme.white,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
