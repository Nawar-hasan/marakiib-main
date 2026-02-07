import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/about_us/data/about_us_repo.dart';
import 'package:marakiib_app/features/about_us/view_model/about_us_cubit.dart';
import 'package:marakiib_app/features/about_us/view_model/about_us_state.dart';

import '../../../core/localization/localization_bloc.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final isArabic = context.watch<LanguageCubit>().isArabic();

    return BlocProvider(
      create: (_) =>
      AboutUsCubit(AboutUsRepository(Dio()))..fetchAboutUs(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate.aboutUs),
          centerTitle: true,
          backgroundColor: AppTheme.white,
        ),
        body: BlocBuilder<AboutUsCubit, AboutUsState>(
          builder: (context, state) {
            if (state is AboutUsLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is AboutUsSuccess) {
              return SingleChildScrollView(
                // padding: const EdgeInsets.all(16),
                child: Directionality(
                  textDirection:
                  isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      // Text(
                      //   state.aboutUs.title,
                      //   style: const TextStyle(
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //     fontFamily: 'Montserrat',
                      //   ),
                      // ),
                      // const SizedBox(height: 16),

                      /// Content (HTML)
                      Html(
                        data: state.aboutUs.content,
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

            if (state is AboutUsError) {
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
