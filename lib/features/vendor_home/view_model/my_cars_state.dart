import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';


abstract class MyCarState {}

class MyCarInitial extends MyCarState {}

class MyCarLoading extends MyCarState {}

class MyCarSuccess extends MyCarState {
  final List<VendorCarModel> cars;
  MyCarSuccess(this.cars);
}

class MyCarFailure extends MyCarState {
  final String error;
  MyCarFailure(this.error);
}
