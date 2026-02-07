import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marakiib_app/features/car_details/data/repository/add_review_repo.dart';
import 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final AddReviewRepo reviewRepo;

  AddReviewCubit({required this.reviewRepo}) : super(AddReviewInitial());

  Future<void> submitReview({
    required int carId,
    required int rating,
    required String comment,
  }) async {
    emit(AddReviewLoading());
    try {
      await reviewRepo.addReview(
        carId: carId,
        rating: rating,
        comment: comment,
      );
      emit(AddReviewSuccess());
    } catch (e) {
      emit(AddReviewFailure(e.toString()));
    }
  }
}
