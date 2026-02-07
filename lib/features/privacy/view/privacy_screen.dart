import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/privacy/data/privacy_repository.dart';
import 'package:marakiib_app/features/privacy/view_model/privacy_cubit.dart';
import 'package:marakiib_app/features/privacy/view_model/privacy_state.dart';

import '../../../core/localization/localization_bloc.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final isArabic = context.watch<LanguageCubit>().isArabic();

    return BlocProvider(
      create: (context) =>
      PrivacyCubit(PrivacyRepository(Dio()))..getPrivacyPage(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate.privacyPolicy),
          centerTitle: true,
          backgroundColor: AppTheme.white,
        ),
        body: BlocBuilder<PrivacyCubit, PrivacyState>(
          builder: (context, state) {
            if (state is PrivacyLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is PrivacySuccess) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Directionality(
                  textDirection:
                  isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // /// Title
                      // Text(
                      //   state.privacy.title,
                      //   style: const TextStyle(
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //     fontFamily: 'Montserrat',
                      //   ),
                      // ),
                      // const SizedBox(height: 16),

                      /// Content (HTML)
                      Html(
                        data: state.privacy.content,
                        style: {
                          "body": Style(
                            fontSize: FontSize(15),
                            lineHeight: LineHeight.number(1.7),
                            color: Colors.black87,
                            fontFamily: 'Montserrat',
                          ),
                          "h2": Style(
                            fontSize: FontSize(18),
                            fontWeight: FontWeight.bold,
                          ),
                          "h3": Style(
                            fontSize: FontSize(16),
                            fontWeight: FontWeight.bold,
                          ),
                          "p": Style(
                            margin: Margins.only(bottom: 12),
                          ),
                          "ul": Style(
                            padding: HtmlPaddings.symmetric(horizontal: 16),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is PrivacyError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
