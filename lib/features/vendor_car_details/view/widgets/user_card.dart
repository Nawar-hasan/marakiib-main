import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/circle_image.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VendorCarModel car;

  const UserCard({super.key, required this.name, required this.imageUrl, required this.car});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${l10n.price}: ${car.rentalPrice?.toStringAsFixed(2) ?? "0.00"}\JOD',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppTheme.primary),
            ),
          ),
          SizedBox(height: 16.h),
          QusetionText(
            question: l10n.longTermGuarantee,
            answer: car.longTermGuarantee ? l10n.yes : l10n.no,
          ),
          SizedBox(height: 16.h),
          QusetionText(
            question: l10n.pickupDelivery,
            answer: car.pickupDelivery ? l10n.yes : l10n.no,
          ),
          SizedBox(height: 16.h),
          QusetionText(
            question: l10n.carAvailabilityStatus,
            answer: car.isActive ? l10n.active : l10n.inactive,
          ),
        ],
      ),
    );
  }
}

class QusetionText extends StatelessWidget {
  final String question;
  final String answer;

  const QusetionText({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$question : ",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: answer,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppTheme.primary),
          ),
        ],
      ),
      softWrap: true,
    );
  }
}
