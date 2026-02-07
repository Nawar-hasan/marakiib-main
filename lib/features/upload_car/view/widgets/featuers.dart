import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/upload_car/data/features_service.dart';
import 'package:marakiib_app/features/upload_car/data/model/features_model.dart';
import 'package:marakiib_app/features/upload_car/view_model/features_cubit.dart';
import 'package:marakiib_app/features/upload_car/view_model/features_state.dart';
import '../../../../core/themeing/app_theme.dart';

class MyFeaturesBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFeaturesSelected;
  final String locale; // 'en' or 'ar'

  const MyFeaturesBottomSheet({
    super.key,
    required this.onFeaturesSelected,
    this.locale = 'en',
  });

  @override
  State<MyFeaturesBottomSheet> createState() => _MyFeaturesBottomSheetState();
}

class _MyFeaturesBottomSheetState extends State<MyFeaturesBottomSheet> {
  Map<int, MyFeatureValue?> selectedFeatures = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              MyFeaturesCubit(MyFeaturesService(Dio()))..getMyFeatures(),
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
        
              // Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.locale == 'ar'
                          ? 'اختر المواصفات'
                          : 'Select Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 24.sp),
                    ),
                  ],
                ),
              ),
        
              Divider(height: 1.h, color: Colors.grey[300]),
        
              // Content
              Expanded(
                child: BlocBuilder<MyFeaturesCubit, MyFeaturesState>(
                  builder: (context, state) {
                    if (state is MyFeaturesLoading) {
                      return const Center(child: LoadingIndicator());
                    } else if (state is MyFeaturesSuccess) {
                      return ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: state.myFeatures.length,
                        itemBuilder: (context, index) {
                          final feature = state.myFeatures[index];
                          return _buildFeatureSection(feature);
                        },
                      );
                    } else if (state is MyFeaturesFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: Colors.red,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              widget.locale == 'ar'
                                  ? 'حدث خطأ في تحميل المواصفات'
                                  : 'Error loading features',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.error,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MyFeaturesCubit>().getMyFeatures();
                              },
                              child: Text(
                                widget.locale == 'ar'
                                    ? 'إعادة المحاولة'
                                    : 'Retry',
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
        
              // Bottom button
              Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      // Create a map with feature IDs as keys and selected values
                      final Map<String, dynamic> selectedFeaturesMap = {};
                      selectedFeatures.forEach((featureId, selectedValue) {
                        if (selectedValue != null) {
                          selectedFeaturesMap[featureId.toString()] =
                              selectedValue.toJson();
                        }
                      });
        
                      widget.onFeaturesSelected(selectedFeaturesMap);
                      Navigator.pop(context);
                    },
                    child: Text(
                      widget.locale == 'ar'
                          ? 'تأكيد الاختيار'
                          : 'Confirm Selection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureSection(MyFeatureModel feature) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Feature title
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Text(
              widget.locale == 'ar'
                  ? _getFeatureArabicTitle(feature.slug)
                  : _getFeatureEnglishTitle(feature.slug),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ),

          // Feature values
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children:
                  feature.values.map((value) {
                    return RadioListTile<MyFeatureValue>(
                      title: Text(
                        value.getTranslation(widget.locale),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: value,
                      groupValue: selectedFeatures[feature.id],
                      onChanged: (MyFeatureValue? selectedValue) {
                        setState(() {
                          selectedFeatures[feature.id] = selectedValue;
                        });
                      },
                      activeColor: AppTheme.primary,
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getFeatureEnglishTitle(String slug) {
    switch (slug) {
      case 'color':
        return 'Color';
      case 'transmission':
        return 'Transmission';
      case 'fuel':
        return 'Fuel Type';
      case 'seats':
        return 'Number of Seats';
      case 'ac':
        return 'Air Conditioning';
      default:
        return slug.toUpperCase();
    }
  }

  String _getFeatureArabicTitle(String slug) {
    switch (slug) {
      case 'color':
        return 'اللون';
      case 'transmission':
        return 'ناقل الحركة';
      case 'fuel':
        return 'نوع الوقود';
      case 'seats':
        return 'عدد المقاعد';
      case 'ac':
        return 'التكييف';
      default:
        return slug;
    }
  }
}
