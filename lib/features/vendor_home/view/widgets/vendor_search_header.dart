// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:marakiib_app/core/themeing/app_theme.dart';
// import 'package:marakiib_app/core/widgets/search_text_field.dart';
// import 'package:marakiib_app/features/user_home/view/widgets/filter_buttom_sheet.dart';
//
// class VendorSearchHeader extends StatelessWidget {
//   const VendorSearchHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       child: Row(
//         children: [
//           SearchTextField(hint: 'Search something here'),
//           SizedBox(width: 12.w),
//           GestureDetector(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder:
//                     (context) => Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.r),
//                           topRight: Radius.circular(20.r),
//                         ),
//                       ),
//                       child: const FilterBottomSheet(),
//                     ),
//               );
//             },
//             child: Container(
//               width: 48.w,
//               height: 48.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: Colors.grey.shade300),
//                 color: AppTheme.white,
//               ),
//               child: Icon(Icons.tune, color: AppTheme.gray400),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
