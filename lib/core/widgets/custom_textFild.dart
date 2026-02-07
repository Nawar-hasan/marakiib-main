import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themeing/app_theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.taskController,
    this.hint = '',
    this.labelText,
    this.showLabelText = true,
    this.maxLines = 1,
    this.ispassword = false,
    this.validate,
    this.icon = Icons.email,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.showPrefixIcon = true,
    this.showFillColor = true,
    this.labelTextStyle,
    this.hintTextStyle,
    this.textStyle,
    this.onChanged,
    this.keyboardType, // ✅ جديد
  });

  final TextEditingController taskController;
  final String hint;
  final String? labelText;
  final bool showLabelText;
  final int maxLines;
  final bool ispassword;
  final String? Function(String?)? validate;
  final IconData? icon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final bool showPrefixIcon;
  final bool showFillColor;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final TextInputType? keyboardType; // ✅ جديد

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

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
              style: widget.labelTextStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        if (widget.showLabelText) const SizedBox(height: 8),

        TextFormField(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.taskController,
          maxLines: widget.maxLines,
          obscureText: widget.ispassword && !_isPasswordVisible,
          validator: widget.validate,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType, // ✅ جديد
          style: widget.textStyle ??
              TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
          decoration: InputDecoration(
            prefixIcon: widget.showPrefixIcon
                ? Icon(widget.icon, color: AppTheme.gray400)
                : null,
            suffixIcon: widget.ispassword
                ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppTheme.gray400,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : widget.suffixIcon,
            hintText: widget.hint,
            hintStyle: widget.hintTextStyle ??
                TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
            alignLabelWithHint: true,
            filled: widget.showFillColor,
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
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: errorBorderColor, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }
}
