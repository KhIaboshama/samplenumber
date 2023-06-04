import 'package:either_dart/either.dart';
import 'package:samplenumber/core/error/failure.dart';

import '../constant/constant.dart';

Either<int, InputInvalidFailure> convertToInt(String input) {
  try {
    return Left(int.parse(input));
  } on Exception {
    return Right(InputInvalidFailure(message: inputInvalidErrorMessage));
  }
}
