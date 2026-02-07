

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themeing/app_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        context.push('/SearchScreen');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.gray),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            Text(
             'Search',

                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:Colors.grey)
            ),

          ],
        ),
      ),
    );
  }
}
