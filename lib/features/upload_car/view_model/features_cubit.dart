import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/upload_car/data/features_service.dart';
import 'package:marakiib_app/features/upload_car/view_model/features_state.dart';

class MyFeaturesCubit extends Cubit<MyFeaturesState> {
  final MyFeaturesService myFeaturesService;

  MyFeaturesCubit(this.myFeaturesService) : super(MyFeaturesInitial());

  Future<void> getMyFeatures() async {
    emit(MyFeaturesLoading());
    try {
      final response = await myFeaturesService.getMyFeatures();
      emit(MyFeaturesSuccess(myFeatures: response.data));
    } catch (e) {
      emit(MyFeaturesFailure(error: e.toString()));
    }
  }

  void resetState() {
    emit(MyFeaturesInitial());
  }
}
