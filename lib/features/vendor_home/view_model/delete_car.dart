import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/core/cash/shared.dart';
import 'package:marakiib_app/core/network/end_point.dart';

class DeleteCarState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  DeleteCarState({this.isLoading = false, this.error, this.isSuccess = false});

  DeleteCarState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return DeleteCarState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class DeleteCarCubit extends Cubit<DeleteCarState> {
  final Dio dio;

  DeleteCarCubit({Dio? dio}) : dio = dio ?? Dio(), super(DeleteCarState());

  Future<void> deleteCar(int carId) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      // Retrieve token from CacheHelper
      final token = await CacheHelper.getString("token");
      if (token == null) {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'No authentication token found. Please log in.',
          ),
        );
        return;
      }

      final response = await dio.delete(
        '${EndPoints.baseUrl}cars/$carId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to delete car';
        emit(state.copyWith(isLoading: false, error: errorMessage));
      }
    } catch (e) {
      String errorMessage = 'Failed to delete car';
      if (e is DioException) {
        errorMessage = e.response?.data['message'] ?? e.message ?? errorMessage;
      }
      emit(state.copyWith(isLoading: false, error: errorMessage));
    }
  }
}

class UpdateCarState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final String? message;

  UpdateCarState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.message,
  });

  UpdateCarState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
    String? message,
  }) {
    return UpdateCarState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }
}

class UpdateCarCubit extends Cubit<UpdateCarState> {
  final Dio dio;

  UpdateCarCubit({Dio? dio}) : dio = dio ?? Dio(), super(UpdateCarState());

  Future<void> updateCar(int carId, FormData formData) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      final token = await CacheHelper.getString("token");
      if (token == null) {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'No authentication token found. Please log in.',
          ),
        );
        return;
      }

      final response = await dio.post(
        '${EndPoints.baseUrl}cars/$carId',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            message: response.data['message'] ?? 'Car updated successfully',
          ),
        );
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to update car';
        emit(state.copyWith(isLoading: false, error: errorMessage));
      }
    } catch (e) {
      String errorMessage = 'Failed to update car';
      if (e is DioException) {
        final resData = e.response?.data;
        if (resData is Map && resData.containsKey('message')) {
          errorMessage = resData['message']?.toString() ?? errorMessage;
        } else if (resData is String) {
          errorMessage =
              resData.length > 100 ? resData.substring(0, 100) : resData;
        } else {
          errorMessage = e.message ?? errorMessage;
        }
      }
      emit(state.copyWith(isLoading: false, error: errorMessage));
    }
  }
}
