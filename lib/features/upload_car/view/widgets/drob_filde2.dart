import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/car_details/data/models/car_details_model.dart';

class DropdownFieldWidget1<T> extends StatelessWidget {
  final String hint;
  final List<dynamic> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;

  const DropdownFieldWidget1({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure unique items to avoid duplicate values
    final uniqueItems = _removeDuplicateItems(items);

    // Verify that selectedValue exists in items (optional, for debugging)
    if (selectedValue != null &&
        !uniqueItems.any((item) => _getItemValue(item) == selectedValue)) {
      debugPrint('⚠️ Warning: selectedValue ($selectedValue) not found in items');
    }

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
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AppTheme.gray400),
      ),
      items: uniqueItems.map((item) {
        String displayText;
        dynamic value;

        if (item is String) {
          displayText = item;
          value = item as T;
        } else if (item is CategoryModel) {
          displayText = item.name;
          value = item.id as T;
        } else if (item is Map<String, String>) {
          displayText = item['label'] ?? '';
          value = item['value'] as T;
        } else {
          displayText = item.toString();
          value = item as T;
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

  // Helper to remove duplicate items based on their value
  List<dynamic> _removeDuplicateItems(List<dynamic> items) {
    final seenValues = <dynamic>{};
    final uniqueItems = <dynamic>[];

    for (var item in items) {
      final value = _getItemValue(item);
      if (!seenValues.contains(value)) {
        seenValues.add(value);
        uniqueItems.add(item);
      }
    }
    return uniqueItems;
  }

  // Helper to extract the value of an item consistently
  dynamic _getItemValue(dynamic item) {
    if (item is String) {
      return item;
    } else if (item is CategoryModel) {
      return item.id;
    } else if (item is Map<String, String>) {
      return item['value'];
    } else {
      return item;
    }
  }
}
