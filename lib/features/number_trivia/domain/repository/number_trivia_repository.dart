
import 'package:either_dart/either.dart';

import '../../data/model/number_trivia_model.dart';

abstract class NumberTriviaRepository {

  Future<Either<NumberTriviaModel, Exception>> getConcreteNumberTrivia(int number);
  Future<Either<NumberTriviaModel, Exception>> getRandomNumberTrivia();
}