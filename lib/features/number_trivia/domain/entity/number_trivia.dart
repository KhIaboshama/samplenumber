import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String description;
  final int number;

  const NumberTrivia({required this.description, required this.number});

  @override
  List<Object?> get props => [description, number];
}
