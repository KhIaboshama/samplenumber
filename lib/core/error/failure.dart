
class Failure {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});
}
class InputInvalidFailure extends Failure {
  final String message;

  InputInvalidFailure({required this.message});
}

