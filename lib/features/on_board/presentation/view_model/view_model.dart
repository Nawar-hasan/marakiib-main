import 'package:flutter_bloc/flutter_bloc.dart';
import 'model.dart';


class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: 'assets/images/23fd4a62a8aed1f665e52c6f551765319f268e5f.png',
      titleKey: 'onboarding_1_title',
      descriptionKey: 'onboarding_1_description',
    ),
    OnBoardingModel(
      image: 'assets/images/0260ba5cc140e59e77706f147401bc2e1f26f094.png',
      titleKey: 'onboarding_2_title',
      descriptionKey: 'onboarding_2_description',
    ),
    OnBoardingModel(
      image: 'assets/images/cc71744f3e758d3f676bbea86af762df60155e79.png',
      titleKey: 'onboarding_3_title',
      descriptionKey: 'onboarding_3_description',
    ),
  ];

  void changePage(int index) {
    emit(index);
  }
}
