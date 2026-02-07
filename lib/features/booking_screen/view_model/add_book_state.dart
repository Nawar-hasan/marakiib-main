abstract class AddBookState {}

class AddBookInitial extends AddBookState {}

class AddBookLoading extends AddBookState {}

class AddBookSuccess extends AddBookState {
  final dynamic data;
  AddBookSuccess(this.data);
}

class AddBookError extends AddBookState {
  final String message;
  AddBookError(this.message);
}
