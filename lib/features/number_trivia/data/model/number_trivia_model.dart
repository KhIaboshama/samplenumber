import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends Equatable {
  final String description;

  const NumberTriviaModel({
    required this.description,
  });

  @override
  List<Object?> get props => [description];

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

}
