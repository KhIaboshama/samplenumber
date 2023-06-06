// Mocks generated by Mockito 5.4.0 from annotations
// in samplenumber/test/features/number_trivia/presentation/number_trivia_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart'
    as _i5;

import 'number_trivia_bloc_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MockNumberTrivialRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockNumberTrivialRepository extends _i1.Mock
    implements _i3.MockNumberTrivialRepository {
  MockMockNumberTrivialRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>
      getConcreteNumberTrivia(int? number) => (super.noSuchMethod(
            Invocation.method(
              #getConcreteNumberTrivia,
              [number],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>.value(
                    _FakeEither_0<_i5.NumberTriviaModel, Exception>(
              this,
              Invocation.method(
                #getConcreteNumberTrivia,
                [number],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>);
  @override
  _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>
      getRandomNumberTrivia() => (super.noSuchMethod(
            Invocation.method(
              #getRandomNumberTrivia,
              [],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>.value(
                    _FakeEither_0<_i5.NumberTriviaModel, Exception>(
              this,
              Invocation.method(
                #getRandomNumberTrivia,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.NumberTriviaModel, Exception>>);
}
