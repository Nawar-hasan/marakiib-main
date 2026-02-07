import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/vendor_home/view_model/financing_state.dart';
import '../data/financing_repo.dart';
import '../data/financing_model.dart';
import 'package:dio/dio.dart';

class FinancingCubit extends Cubit<FinancingState> {
  final FinancingRepository _repository;

  FinancingCubit(this._repository) : super(FinancingInitial());

  Future<void> addFinancing(FinancingModel model) async {
    emit(FinancingLoading());
    try {
      final response = await _repository.addFinancing(model);
      emit(FinancingSuccess(response.data["message"] ?? "Financing request sent successfully"));
    } on DioException catch (e) {
      final message = e.response?.data?["message"] ?? "Something went wrong";
      emit(FinancingError(message));
    } catch (e) {
      emit(FinancingError("Unexpected error: $e"));
    }
  }
}
