part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent {}

class GetConcreteNumberEvent extends NumberTriviaEvent {
  final String number;

  GetConcreteNumberEvent({required this.number});
}
