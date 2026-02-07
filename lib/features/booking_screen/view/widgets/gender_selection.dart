import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class GenderSelection extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelection({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.gender,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            _buildGenderButton(translate.male, Icons.male),
            SizedBox(width: 16.w),
            _buildGenderButton(translate.female, Icons.female),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(String gender, IconData icon) {
    final bool isSelected = selectedGender == gender;
    final Color color =
        gender == 'Male' ? AppTheme.primary : const Color(0xFFDC143C);

    return GestureDetector(
      onTap: () => onGenderSelected(gender),
      child: Container(
        width: 80.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(60.r),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            SizedBox(width: 1.w),
            Text(
              gender,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
