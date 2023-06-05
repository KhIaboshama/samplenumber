import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exception.dart';
import '../model/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<Either<NumberTriviaModel, Exception>> getConcreteNumberTrivia(
      int number);

  Future<Either<NumberTriviaModel, Exception>> getRandomNumberTrivia();

  String getNumberConcreteTriviaUrl(int number) => "$baseUrl/$number";

  String getNumberRandomTriviaUrl() => "$baseUrl/random";
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<NumberTriviaModel, Exception>> getConcreteNumberTrivia(
      int number) async {
    final url = Uri.parse(getNumberConcreteTriviaUrl(number));
    final response =
        await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Left(NumberTriviaModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Right(
          ServerException(message: somethingWentWrongErrorMessage));
    }
  }

  @override
  Future<Either<NumberTriviaModel, Exception>> getRandomNumberTrivia() async {
    final url = Uri.parse(getNumberRandomTriviaUrl());
    final response =
        await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Left(NumberTriviaModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Right(
          ServerException(message: somethingWentWrongErrorMessage));
    }
  }
}
