import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:samplenumber/features/number_trivia/domain/entity/number_trivia.dart';

NumberTrivia toNumberTrivia(NumberTriviaModel numberTriviaModel, int number) =>
    NumberTrivia(
      description: numberTriviaModel.text,
      number: number,
    );
