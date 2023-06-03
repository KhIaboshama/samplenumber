import 'package:either_dart/either.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/core/usecase/usecase.dart';
import 'package:samplenumber/features/number_trivia/domain/entity/number_trivia.dart';

import '../../../../core/error/failure.dart';
import '../mapper.dart';
import '../repository/NumberTriviaRepository.dart';

class GetConcreteNumberTriviaUsecase
    extends Usecase<NumberTrivia, ConcreteNumberTriviaParam> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase({required this.repository});

  @override
  Future<Either<NumberTrivia, Failure>> call(
      ConcreteNumberTriviaParam params) async {
    final response = await repository.getConcreteNumberTrivia(params.number);
    if (response.isLeft) {
      return Left(toNumberTrivia(response.left, params.number));
    } else {
      if (response.right is ServerException) {
        return Right(ServerFailure(
            message: (response.right as ServerException).message));
      } else {
        return Right(ServerFailure(message: somethingWentWrongErrorMessage));
      }
    }
  }
}

class ConcreteNumberTriviaParam extends Params {
  final int number;

  ConcreteNumberTriviaParam(this.number);
}
