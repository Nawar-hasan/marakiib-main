import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

class DropdownFieldWidget<T> extends StatelessWidget {
  final String hint;
  final List<dynamic> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;

  const DropdownFieldWidget({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppTheme.gray2, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppTheme.gray2, width: 0.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppTheme.primary, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppTheme.primary, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppTheme.gray2, width: 0.6),
        ),
      ),
      hint: Text(
        hint,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppTheme.black),
      ),
      items: items.map((item) {
        String displayText;
        dynamic value;

        if (item is String) {
          displayText = item;
          value = item;
        } else if (item is CategoryModel) {
          displayText = item.name;
          value = item.id as T;
        } else if (item is Map<String, dynamic>) {
          displayText = item['label'] as String;
          value = item['value'] as T;
        } else {
          displayText = item.toString();
          value = item;
        }

        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            displayText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      }).toList(),
      value: selectedValue,
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }
}
