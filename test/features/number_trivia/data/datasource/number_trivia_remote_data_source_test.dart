import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart';

import 'number_trivia_remote_data_source_test.mocks.dart';


class MockNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

@GenerateMocks(<Type>[MockNumberTriviaRemoteDataSource])
void main() {
  late MockMockNumberTriviaRemoteDataSource mock;
  NumberTriviaModel numberTriviaModel =
      const NumberTriviaModel(text: 'success');
  final serverException =
      ServerException(message: somethingWentWrongErrorMessage);
  setUp(() {
    mock = MockMockNumberTriviaRemoteDataSource();
  });

  test('returns number trivia string when http response is successful',
      () async {
    const number = 1;
    when(mock.getConcreteNumberTrivia(number))
        .thenAnswer((_) async => Left(numberTriviaModel));

    final response = await mock.getConcreteNumberTrivia(number);
    expect(response.left, numberTriviaModel);
  });
  test('returns exception when http response is failure', () async {
    const number = 1;
    when(mock.getConcreteNumberTrivia(number))
        .thenAnswer((_) async => Right(serverException));

    final response = await mock.getConcreteNumberTrivia(number);
    expect(response.right, serverException);
  });

  test('returns random number trivia string when http response is successful',
      () async {
    when(mock.getRandomNumberTrivia())
        .thenAnswer((_) async => Left(numberTriviaModel));

    final response = await mock.getRandomNumberTrivia();
    expect(response.left, numberTriviaModel);
  });
  test('returns exception when getting random http response is failure', () async {
    when(mock.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(serverException));

    final response = await mock.getRandomNumberTrivia();
    expect(response.right, serverException);
  });
}
