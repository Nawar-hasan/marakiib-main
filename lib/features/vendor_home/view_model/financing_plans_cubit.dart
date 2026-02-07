import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/core/network/end_point.dart';
import 'package:marakiib_app/features/vendor_home/data/financing_plan_model.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_plans_cubit.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_plans_state.dart';

class FinancingPlansCubit extends Cubit<FinancingPlansState> {
  FinancingPlansCubit() : super(FinancingPlansInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  Future<void> getFinancingPlans() async {
    emit(FinancingPlansLoading());
    try {
      final response = await _dio.get(EndPoints.financingPlans);

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List data = response.data['data'];
        final plans = data.map((e) => FinancingPlanModel.fromJson(e)).toList();
        emit(FinancingPlansSuccess(plans));
      } else {
        emit(FinancingPlansFailure(response.data['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      emit(FinancingPlansFailure(e.toString()));
    }
  }
}
