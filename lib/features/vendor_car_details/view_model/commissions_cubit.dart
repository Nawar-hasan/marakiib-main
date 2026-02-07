  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:dio/dio.dart';
  import 'package:marakiib_app/core/network/end_point.dart';
  import 'package:marakiib_app/features/vendor_car_details/view/data/commissions_model.dart';
  import 'package:marakiib_app/features/vendor_car_details/view_model/commissions_state.dart';

  class CommissionCubit extends Cubit<CommissionState> {
    CommissionCubit() : super(CommissionInitial());

    final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

    Future<void> getCommissions() async {
      emit(CommissionLoading());

      try {
        final response = await _dio.get(EndPoints.commissions);

        if (response.statusCode == 200 &&
            response.data['status'] == 'success') {
          final List data = response.data['data'];
          final commissions =
          data.map((e) => CommissionModel.fromJson(e)).toList();

          emit(CommissionSuccess(commissions));
        } else {
          emit(CommissionError(response.data['message'] ?? 'Something went wrong'));
        }
      } catch (error) {
        emit(CommissionError(error.toString()));
      }
    }
  }
