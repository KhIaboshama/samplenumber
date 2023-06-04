import 'package:either_dart/either.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/core/usecase/usecase.dart';
import 'package:samplenumber/features/number_trivia/domain/entity/number_trivia.dart';

import '../../../../core/error/failure.dart';
import '../mapper.dart';
import '../repository/number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase extends Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUsecase({required this.repository});

  @override
  Future<Either<NumberTrivia, Failure>> call(NoParams params) async {
    final response = await repository.getRandomNumberTrivia();
    if (response.isLeft) {
      return Left(toNumberTrivia(
          response.left, int.parse(response.left.text.split("")[0])));
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

class NoParams extends Params {
  NoParams();
}
