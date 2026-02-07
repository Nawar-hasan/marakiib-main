abstract class FinancingState {}

class FinancingInitial extends FinancingState {}

class FinancingLoading extends FinancingState {}

class FinancingSuccess extends FinancingState {
  final String message;
  FinancingSuccess(this.message);
}

class FinancingError extends FinancingState {
  final String error;
  FinancingError(this.error);
}
