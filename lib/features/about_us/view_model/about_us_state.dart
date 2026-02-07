import 'package:marakiib_app/features/about_us/data/model/about_us_model.dart';


abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsSuccess extends AboutUsState {
  final AboutUsModel aboutUs;
  AboutUsSuccess(this.aboutUs);
}

class AboutUsError extends AboutUsState {
  final String message;
  AboutUsError(this.message);
}
