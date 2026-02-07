import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class PriceField extends StatefulWidget {
  final String header;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const PriceField({
    super.key,
    required this.header,
    this.hintText = "Enter price",
    this.controller,
    this.onChanged,
  });

  @override
  State<PriceField> createState() => _PriceFieldState();
}

class _PriceFieldState extends State<PriceField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.header, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 4.h),
        TextField(
          cursorColor: AppTheme.primary,
          controller: _controller,
          keyboardType: TextInputType.number,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            suffixText: "\JOD ",
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppTheme.gray1010,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
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
