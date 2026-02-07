import 'package:marakiib_app/features/vendor_car_details/view/data/commissions_model.dart';


abstract class CommissionState {}

class CommissionInitial extends CommissionState {}

class CommissionLoading extends CommissionState {}

class CommissionSuccess extends CommissionState {
  final List<CommissionModel> commissions;
  CommissionSuccess(this.commissions);
}

class CommissionError extends CommissionState {
  final String message;
  CommissionError(this.message);
}
