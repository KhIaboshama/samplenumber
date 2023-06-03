part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState {}

class NumberTriviaInitialState extends NumberTriviaState {}

class NumberTriviaLoadingState extends NumberTriviaState {}

class NumberTriviaLoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  NumberTriviaLoadedState({required this.numberTrivia});
}

class NumberTriviaErrorState extends NumberTriviaState {
  final String message;

  NumberTriviaErrorState({required this.message});
}


