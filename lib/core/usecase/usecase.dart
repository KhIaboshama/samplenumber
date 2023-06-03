

import 'package:either_dart/either.dart';

import '../error/failure.dart';

abstract class Usecase<Type, Params> {

  Future<Either<Type, Failure>> call(Params params);
}

abstract class Params {}