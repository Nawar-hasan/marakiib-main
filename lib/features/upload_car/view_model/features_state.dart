import 'package:marakiib_app/features/upload_car/data/model/features_model.dart';

abstract class MyFeaturesState {}

class MyFeaturesInitial extends MyFeaturesState {}

class MyFeaturesLoading extends MyFeaturesState {}

class MyFeaturesSuccess extends MyFeaturesState {
  final List<MyFeatureModel> myFeatures;

  MyFeaturesSuccess({required this.myFeatures});
}

class MyFeaturesFailure extends MyFeaturesState {
  final String error;

  MyFeaturesFailure({required this.error});
}
