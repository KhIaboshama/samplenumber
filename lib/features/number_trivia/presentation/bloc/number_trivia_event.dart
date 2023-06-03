part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent {}

class GetConcreteNumberEvent extends NumberTriviaEvent {
  final int number;

  GetConcreteNumberEvent({required this.number});
}
