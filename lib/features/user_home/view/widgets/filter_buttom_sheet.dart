// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:marakiib_app/core/themeing/app_theme.dart';
// import 'package:marakiib_app/core/widgets/custom_icon_button.dart';
// import 'package:marakiib_app/features/user_home/view/widgets/date_picker.dart';
// import 'package:marakiib_app/features/user_home/view/widgets/location_field.dart';
// import 'package:marakiib_app/features/user_home/view/widgets/price_field.dart';
// import 'package:marakiib_app/features/user_home/view/widgets/section_title.dart';
// import 'package:marakiib_app/features/search_home/view_model/cubit/search_cubit.dart';
//
// class FilterBottomSheet extends StatefulWidget {
//   final String? searchQuery;
//   final SearchCubit searchCubit;
//
//   const FilterBottomSheet({
//     super.key,
//     this.searchQuery,
//     required this.searchCubit,
//   });
//
//   @override
//   State<FilterBottomSheet> createState() => _FilterBottomSheetState();
// }
//
// class _FilterBottomSheetState extends State<FilterBottomSheet> with SingleTickerProviderStateMixin {
//   final TextEditingController minPriceController = TextEditingController();
//   final TextEditingController maxPriceController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   String? selectedRentalTime;
//   String? selectedCarColor;
//   DateTime? selectedDate;
//   bool useCurrentLocation = true;
//
//   final List<String> rentalOptions = ['Hour', 'Day', 'Weekly', 'Monthly'];
//   final List<String> carColors = ['White', 'Green', 'Black', 'Silver', 'Red', 'Blue'];
//   final Map<String, int> rentalTimeToTypeId = {
//     'Hour': 1,
//     'Day': 2,
//     'Weekly': 3,
//     'Monthly': 4,
//   };
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedLocation();
//     _setupAnimations();
//   }
//
//   void _setupAnimations() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//     _animationController.forward();
//   }
//
//   Future<void> _loadSavedLocation() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final savedAddress = prefs.getString("user_address");
//       if (savedAddress != null && mounted) {
//         setState(() {
//           locationController.text = savedAddress;
//         });
//       }
//     } catch (e) {
//       _showErrorSnackBar("Error loading saved location: $e");
//     }
//   }
//
//   Future<void> _applyFilters() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       double? latitude;
//       double? longitude;
//
//       if (useCurrentLocation) {
//         latitude = prefs.getDouble("user_lat");
//         longitude = prefs.getDouble("user_lng");
//         if (latitude == null || longitude == null) {
//           _showErrorSnackBar("Current location not available");
//           return;
//         }
//       }
//
//       double? minPrice = minPriceController.text.isNotEmpty
//           ? double.tryParse(minPriceController.text)
//           : null;
//       double? maxPrice = maxPriceController.text.isNotEmpty
//           ? double.tryParse(maxPriceController.text)
//           : null;
//
//       if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
//         _showErrorSnackBar("Minimum price cannot exceed maximum price");
//         return;
//       }
//
//       int? carTypeId = selectedRentalTime != null
//           ? rentalTimeToTypeId[selectedRentalTime]
//           : null;
//
//       await widget.searchCubit.searchCars(
//         query: widget.searchQuery,
//         priceMin: minPrice,
//         priceMax: maxPrice,
//         carTypeId: carTypeId,
//         nearest: useCurrentLocation,
//         latitude: latitude,
//         longitude: longitude,
//       );
//
//       if (mounted) {
//         context.pop();
//       }
//     } catch (e) {
//       _showErrorSnackBar("Error applying filters: $e");
//     }
//   }
//
//   void _clearFilters() {
//     setState(() {
//       minPriceController.clear();
//       maxPriceController.clear();
//       locationController.clear();
//       selectedRentalTime = null;
//       selectedCarColor = null;
//       selectedDate = null;
//       useCurrentLocation = true;
//     });
//
//     widget.searchCubit.searchCars(query: widget.searchQuery);
//   }
//
//   void _showErrorSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppTheme.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 16.w,
//               right: 16.w,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 12.h),
//                   _buildHeader(),
//                   Divider(height: 18.h, color: AppTheme.gray1010),
//                   SizedBox(height: 12.h),
//                   _buildPriceRangeSection(),
//                   Divider(height: 32.h, color: AppTheme.gray1010),
//                   _buildRentalTimeSection(),
//                   _buildDatePickerSection(),
//                   Divider(height: 32.h, color: AppTheme.gray1010),
//                   _buildLocationSection(),
//                   Divider(height: 32.h, color: AppTheme.gray1010),
//                   _buildCarColorSection(),
//                   SizedBox(height: 30.h),
//                   _buildApplyButton(),
//                   SizedBox(height: 16.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Text(
//           'Filters',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.sp,
//           ),
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: CustomIconButton(
//             icon: Icons.close,
//             onTap: () => context.pop(),
//             backgroundColor: Colors.transparent,
//             boxShadow: const [BoxShadow(color: Colors.transparent)],
//           ),
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: TextButton(
//             onPressed: _clearFilters,
//             child: Text(
//               'Clear',
//               style: TextStyle(
//                 color: AppTheme.primary,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPriceRangeSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(title: 'Price Range'),
//         SizedBox(height: 16.h),
//         Row(
//           children: [
//             Expanded(
//               child: PriceField(
//                 hintText: '50',
//                 controller: minPriceController,
//                 header: 'Minimum',
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: PriceField(
//                 hintText: '200',
//                 controller: maxPriceController,
//                 header: 'Maximum',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRentalTimeSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(title: 'Rental Time'),
//         SizedBox(height: 8.h),
//         Wrap(
//           spacing: 8.w,
//           runSpacing: 8.h,
//           children: rentalOptions.map((option) {
//             final isSelected = selectedRentalTime == option;
//             return ChoiceChip(
//               label: Text(option),
//               selected: isSelected,
//               onSelected: (_) => setState(() => selectedRentalTime = option),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24.r),
//                 side: BorderSide(
//                   color: isSelected ? AppTheme.primary : AppTheme.gray1010,
//                 ),
//               ),
//               selectedColor: AppTheme.primary,
//               backgroundColor: AppTheme.gray1,
//               showCheckmark: false,
//               labelStyle: TextStyle(
//                 color: isSelected ? AppTheme.white : AppTheme.black,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDatePickerSection() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 24.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SectionTitle(title: 'Pick up and Drop Date'),
//           DatePickerField(
//             header: "Select Date",
//             selectedDate: selectedDate,
//             onDateSelected: (date) => setState(() => selectedDate = date),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLocationSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(title: 'Car Location'),
//         SizedBox(height: 12.h),
//         Row(
//           children: [
//             Checkbox(
//               value: useCurrentLocation,
//               onChanged: (value) => setState(() => useCurrentLocation = value ?? true),
//               activeColor: AppTheme.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4.r),
//               ),
//             ),
//             Text(
//               'Use my current location',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontSize: 14.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         LocationField(
//           hintText: 'Shore Dr, Chicago 6062, USA',
//           controller: locationController,
//           enabled: !useCurrentLocation,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCarColorSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionTitle(title: 'Car Color'),
//         SizedBox(height: 8.h),
//         Wrap(
//           spacing: 8.w,
//           runSpacing: 8.h,
//           children: carColors.map((color) {
//             final isSelected = selectedCarColor == color;
//             return ChoiceChip(
//               label: Text(color),
//               selected: isSelected,
//               onSelected: (_) => setState(() => selectedCarColor = color),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24.r),
//                 side: BorderSide(
//                   color: isSelected ? AppTheme.primary : AppTheme.gray1010,
//                 ),
//               ),
//               selectedColor: AppTheme.primary,
//               backgroundColor: AppTheme.gray1,
//               showCheckmark: false,
//               labelStyle: TextStyle(
//                 color: isSelected ? AppTheme.white : AppTheme.black,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildApplyButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: ElevatedButton(
//         onPressed: _applyFilters,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppTheme.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           elevation: 2,
//         ),
//         child: Text(
//           'Apply Filters',
//           style: TextStyle(
//             color: AppTheme.white,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     minPriceController.dispose();
//     maxPriceController.dispose();
//     locationController.dispose();
//     super.dispose();
//   }
// }
