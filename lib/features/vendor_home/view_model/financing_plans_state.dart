
import 'package:marakiib_app/features/vendor_home/data/financing_plan_model.dart';

abstract class FinancingPlansState {}

class FinancingPlansInitial extends FinancingPlansState {}

class FinancingPlansLoading extends FinancingPlansState {}

class FinancingPlansSuccess extends FinancingPlansState {
  final List<FinancingPlanModel> plans;

  FinancingPlansSuccess(this.plans);
}

class FinancingPlansFailure extends FinancingPlansState {
  final String error;

  FinancingPlansFailure(this.error);
}
