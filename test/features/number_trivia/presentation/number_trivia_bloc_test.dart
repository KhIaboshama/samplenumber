import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:samplenumber/features/number_trivia/domain/entity/number_trivia.dart';
import 'package:samplenumber/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:samplenumber/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

class MockNumberTrivialRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks(<Type>[MockNumberTrivialRepository])
void main() {
  late MockMockNumberTrivialRepository repository;
  late NumberTriviaBloc bloc;
  setUp(() {
    repository = MockMockNumberTrivialRepository();
    bloc = NumberTriviaBloc(repository);
  });
  const number = 1;

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'get concrete number trivia from event with success response',
    build: () => bloc,
    act: (bloc) {
      when(repository.getConcreteNumberTrivia(number))
          .thenAnswer((_) async => const Left(NumberTriviaModel(text: "test")));

      return bloc.add(GetConcreteNumberEvent(number: number.toString()));
    },
    expect: () => [
      NumberTriviaLoadingState(),
      NumberTriviaLoadedState(
        numberTrivia: const NumberTrivia(description: 'test', number: number),
      ),
    ],
  );
  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'get concrete number trivia from event with failure response',
    build: () => bloc,
    act: (bloc) {
      when(repository.getConcreteNumberTrivia(number)).thenAnswer((_) async =>
          const Right(
              ServerException(message: somethingWentWrongErrorMessage)));

      return bloc.add(GetConcreteNumberEvent(number: number.toString()));
    },
    expect: () => [
      NumberTriviaLoadingState(),
      NumberTriviaErrorState(
        message: somethingWentWrongErrorMessage,
      ),
    ],
  );

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'get random number trivia from event with success response',
    build: () => bloc,
    act: (bloc) {
      when(repository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Left(NumberTriviaModel(text: "1 test")));

      return bloc.add(GetRandomNumberEvent());
    },
    expect: () => [
      NumberTriviaLoadingState(),
      NumberTriviaLoadedState(
        numberTrivia: const NumberTrivia(description: '1 test', number: number),
      ),
    ],
  );
  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'get random number trivia from event with failure response',
    build: () => bloc,
    act: (bloc) {
      when(repository.getRandomNumberTrivia()).thenAnswer((_) async =>
          const Right(
              ServerException(message: somethingWentWrongErrorMessage)));

      return bloc.add(GetRandomNumberEvent());
    },
    expect: () => [
      NumberTriviaLoadingState(),
      NumberTriviaErrorState(
        message: somethingWentWrongErrorMessage,
      ),
    ],
  );
}
