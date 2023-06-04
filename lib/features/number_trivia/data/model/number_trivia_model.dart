import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends Equatable {
  final String text;

  const NumberTriviaModel({
    required this.text,
  });

  @override
  List<Object?> get props => [text];

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

}
