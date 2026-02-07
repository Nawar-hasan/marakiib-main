import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/features/vendor_home/view_model/my_cars_state.dart';
import '../data/my_car_service.dart';

class MyCarCubit extends Cubit<MyCarState> {
  final MyCarService myCarService;

  MyCarCubit(this.myCarService) : super(MyCarInitial());

  Future<void> fetchMyCars() async {
    if (isClosed) return; // لو اتقفل خلاص مش هنعمل emit
    emit(MyCarLoading());

    try {
      final response = await myCarService.getMyCars();

      if (isClosed) return;
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data["data"] ?? [];
        final cars = list.map((e) => VendorCarModel.fromJson(e)).toList();
        emit(MyCarSuccess(cars));
      } else {
        emit(MyCarFailure("Unexpected status code: ${response.statusCode}"));
      }
    } catch (e) {
      if (isClosed) return;
      emit(MyCarFailure(e.toString()));
    }
  }
}
