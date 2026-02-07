import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';

class SearchTextField extends StatefulWidget {
  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _controller;

  void _listener() {
    if (!mounted) return; // ✅ مهم جدًا
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    _controller.removeListener(_listener); // ✅ أهم حاجة
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppTheme.gray400),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: TextStyle(color: AppTheme.gray400),
                ),
              ),
            ),
            if (_controller.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  FocusScope.of(context).unfocus();
                },
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: AppTheme.gray400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
