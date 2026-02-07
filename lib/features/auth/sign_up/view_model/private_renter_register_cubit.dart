import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/data/data_source/private_renter_register_repository.dart';
import '../view/data/model/private_renter_register_model.dart';
import 'private_renter_register_state.dart';

class PrivateRenterRegisterCubit extends Cubit<PrivateRenterRegisterState> {
  final PrivateRenterRegisterRepository repository;

  PrivateRenterRegisterCubit(this.repository)
    : super(PrivateRenterRegisterInitial());

  Future<void> register(PrivateRenterRegisterModel user) async {
    emit(PrivateRenterRegisterLoading());

    try {
      final response = await repository.registerPrivateRenter(user);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data["message"] ?? "Registration success";
        emit(PrivateRenterRegisterSuccess(message));
      } else {
        final errorMessage = response.data["message"] ?? "Registration failed";
        emit(PrivateRenterRegisterFailure(errorMessage));
      }
    } catch (e) {
      emit(PrivateRenterRegisterFailure('Registration failed'));
    }
  }
}
