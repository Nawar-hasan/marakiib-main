import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final Function(String fullNumber)? onChanged;

  const CustomPhoneField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  Country _selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: '0100 123 4567',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'EG',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
      final translate = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: AppTheme.gray1,
            border: Border.all(
              color: AppTheme.gray50,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                      });
                      _emitFullNumber(widget.controller.text);
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Text(
                        _selectedCountry.flagEmoji,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '+${_selectedCountry.phoneCode}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.gray400,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: AppTheme.gray400),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 32.h,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: TextFormField(
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  controller: widget.controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  validator: widget.validator,
                  onChanged: (value) => _emitFullNumber(value),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration:  InputDecoration(
                    hintText: translate.phoneError,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _emitFullNumber(String value) {
    final fullNumber = '+${_selectedCountry.phoneCode}$value';
    if (widget.onChanged != null) {
      widget.onChanged!(fullNumber);
    }
  }
}
