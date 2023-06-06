part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {}

class NumberTriviaInitialState extends NumberTriviaState {
  @override
  List<Object?> get props => [];
}

class NumberTriviaLoadingState extends NumberTriviaState {
  @override
  List<Object?> get props => [];

}

class NumberTriviaLoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  NumberTriviaLoadedState({required this.numberTrivia});

  @override
  List<Object?> get props => [numberTrivia];

}

class NumberTriviaErrorState extends NumberTriviaState {
  final String message;

  NumberTriviaErrorState({required this.message});

  @override
  List<Object?> get props => [message];

}


