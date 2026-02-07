import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart'; // ⬅️ الترجمة
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_icon_button.dart';

class UploadImagesSection extends StatelessWidget {
  final VoidCallback onPickMainImage;
  final File? mainImage;
  final VoidCallback onPickExtraImages;
  final List<File> extraImages;

  const UploadImagesSection({
    super.key,
    required this.onPickMainImage,
    required this.mainImage,
    required this.onPickExtraImages,
    required this.extraImages,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!; // ⬅️ نجيب الترجمات

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.uploadCarImages, // ⬅️ بدل "Upload Cars images"
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      translate.mainImage, // ⬅️ بدل "Main Image"
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  CustomIconButton(
                    height: 42.h,
                    backgroundColor: AppTheme.primary,
                    icon: Icons.add_a_photo_outlined,
                    iconColor: AppTheme.white,
                    boxShadow: const [BoxShadow(color: Colors.transparent)],
                    onTap: onPickMainImage,
                  ),
                ],
              ),
              if (mainImage != null && mainImage!.existsSync()) ...[
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    mainImage!,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      translate.extraImages, // ⬅️ بدل "Extra Images"
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  CustomIconButton(
                    height: 42.h,
                    backgroundColor: AppTheme.primary,
                    icon: Icons.photo_size_select_actual_outlined,
                    iconColor: AppTheme.white,
                    boxShadow: const [BoxShadow(color: Colors.transparent)],
                    onTap: onPickExtraImages,
                  ),
                ],
              ),
              if (extraImages.isNotEmpty) ...[
                SizedBox(height: 8.h),
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: extraImages.length,
                    itemBuilder: (context, index) {
                      if (extraImages[index].existsSync()) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              extraImages[index],
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
