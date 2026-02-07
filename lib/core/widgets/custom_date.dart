import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themeing/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themeing/app_theme.dart';

class CustomDatePickerField extends StatefulWidget {
  const CustomDatePickerField({
    super.key,
    required this.controller,
    this.hint = 'Select Date',
    this.labelText,
    this.showLabelText = true,
    this.icon = Icons.calendar_today,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final String? labelText;
  final bool showLabelText;
  final IconData icon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final String? Function(String?)? validator;

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String month = picked.month.toString().padLeft(2, '0');
      String day = picked.day.toString().padLeft(2, '0');
      String year = picked.year.toString();

      setState(() {
        widget.controller.text = "$month/$day/$year"; // ✅ فورمات شهر/يوم/سنة مع صفر بادئات
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final Color fillColor = widget.fillColor ?? AppTheme.gray1;
    final Color borderColor = widget.borderColor ?? AppTheme.gray50;
    final Color focusedBorderColor =
        widget.focusedBorderColor ?? AppTheme.primary;
    final Color errorBorderColor = widget.errorBorderColor ?? Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabelText)
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              widget.labelText ?? widget.hint,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        if (widget.showLabelText) const SizedBox(height: 8),

        TextFormField(
          controller: widget.controller,
          readOnly: true,
          validator: widget.validator,
          onTap: _pickDate,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: AppTheme.gray400),
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: errorBorderColor, width: 1.5),
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }
}

