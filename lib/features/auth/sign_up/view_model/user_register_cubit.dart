import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/data/data_source/register_service.dart';
import '../view/data/model/register_model.dart';
import 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  final UserRegisterRepository repository;

  UserRegisterCubit(this.repository) : super(UserRegisterInitial());

  Future<void> register(UserRegisterModel user) async {
    emit(UserRegisterLoading());

    try {
      final response = await repository.registerUser(user);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UserRegisterSuccess(
          response.data["message"] ?? "Registration success",
        ));
      } else {

        final errorMessage = response.data["message"] ?? "Registration failed";
        emit(UserRegisterFailure(errorMessage));
      }
    } on DioError catch (e) {

      String message = "Registration failed";

      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          if (data.containsKey("message")) {
            message = data["message"];
          } else if (data.containsKey("errors")) {

            message = (data["errors"] as Map<String, dynamic>)
                .values
                .map((e) => e[0])
                .join("\n");
          }
        }
      }

      emit(UserRegisterFailure(message));
    } catch (e) {

      emit(UserRegisterFailure(e.toString()));
    }
  }
}
