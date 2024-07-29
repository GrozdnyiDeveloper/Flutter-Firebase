part of 'book_cubit.dart';

@immutable
sealed class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookSuccess extends BookState {}

class BookError extends BookState {}

