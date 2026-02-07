import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturesDropButton<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final List<String>? itemLabels;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;

  const FeaturesDropButton({
    super.key,
    required this.hint,
    required this.items,
    this.itemLabels,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
      value: selectedValue,
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            itemLabels != null && index < itemLabels!.length
                ? itemLabels![index]
                : value.toString(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
