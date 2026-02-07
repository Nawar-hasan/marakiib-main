import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/user_profile_tab/data/user_model.dart';
import 'package:marakiib_app/features/user_profile_tab/data/user_service.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;

  UserCubit(this.userService) : super(UserInitial());

  Future<void> fetchUser() async {
    emit(UserLoading());
    try {
      final response = await userService.getUser();

      final user = UserModel.fromJson(response.data);
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
