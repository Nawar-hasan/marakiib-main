import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailsViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedGender = 'Male';
  DateTime? startDate;
  DateTime? endDate;

  void setGender(String gender) {
    selectedGender = gender;
  }

  String? getFormattedStartDate() {
    if (startDate == null) return null;
    final dateTime = DateTime(startDate!.year, startDate!.month, startDate!.day, 10, 0, 0);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  String? getFormattedEndDate() {
    if (endDate == null) return null;
    final dateTime = DateTime(endDate!.year, endDate!.month, endDate!.day, 10, 0, 0);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}
