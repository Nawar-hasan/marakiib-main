import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/auth/sign_up/view_model/rental_office_register_state.dart';
import '../view/data/data_source/rental_office_register_repository.dart';
import '../view/data/model/rental_office_register_model.dart';

class RentalOfficeRegisterCubit extends Cubit<RentalOfficeRegisterState> {
  final RentalOfficeRegisterRepository repository;

  RentalOfficeRegisterCubit(this.repository)
      : super(RentalOfficeRegisterInitial());

  Future<void> register(RentalOfficeRegisterModel user) async {
    emit(RentalOfficeRegisterLoading());

    try {
      final response = await repository.registerRentalOffice(user);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data["message"] ?? "Registration success";
        emit(RentalOfficeRegisterSuccess(message));
      } else {
        final errorMessage = response.data["message"] ?? "Registration failed";
        emit(RentalOfficeRegisterFailure(errorMessage));
      }
    } catch (e) {
      emit(RentalOfficeRegisterFailure(e.toString()));
    }
  }
}
