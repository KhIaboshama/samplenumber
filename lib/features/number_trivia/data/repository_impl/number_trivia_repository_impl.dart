

import 'package:either_dart/src/either.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:samplenumber/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:samplenumber/features/number_trivia/domain/repository/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;

  NumberTriviaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<NumberTriviaModel, Exception>> getConcreteNumberTrivia(int number) async {
    final response = await remoteDataSource.getConcreteNumberTrivia(number);
    if (response.isLeft) {
      return Left(response.left);
    } else {
      return Right(response.right);
    }
  }

}