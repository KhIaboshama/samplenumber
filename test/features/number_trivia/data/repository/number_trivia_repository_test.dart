import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:samplenumber/features/number_trivia/domain/repository/number_trivia_repository.dart';

import 'number_trivia_repository_test.mocks.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks(<Type>[MockNumberTriviaRepository])
void main() {
  late MockMockNumberTriviaRepository repository;
  NumberTriviaModel numberTriviaModel =
      const NumberTriviaModel(text: 'success');
  final serverException =
      ServerException(message: somethingWentWrongErrorMessage);

  setUp(() {
    repository = MockMockNumberTriviaRepository();
  });

  test('returns number trivia string when http response is successful', () async {
    const number = 1;
    when(repository.getConcreteNumberTrivia(number)).thenAnswer((_) async {
      return Left(numberTriviaModel);
    });
    final result = await repository.getConcreteNumberTrivia(number);
    expect(result.left, numberTriviaModel);
  });
  test('returns exception when http response is failure', () async {
    const number = 1;
    when(repository.getConcreteNumberTrivia(number)).thenAnswer((_) async {
      return Right(serverException);
    });
    final result = await repository.getConcreteNumberTrivia(number);
    expect(result.right, serverException);
  });
  test('returns random number trivia string when http response is successful', () async {
    when(repository.getRandomNumberTrivia()).thenAnswer((_) async {
      return Left(numberTriviaModel);
    });
    final result = await repository.getRandomNumberTrivia();
    expect(result.left, numberTriviaModel);
  });
  test('returns exception when getting random http response is failure', () async {
    when(repository.getRandomNumberTrivia()).thenAnswer((_) async {
      return Right(serverException);
    });
    final result = await repository.getRandomNumberTrivia();
    expect(result.right, serverException);
  });
}
