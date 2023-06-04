import 'package:flutter_test/flutter_test.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/util/input_converter.dart';

void main() {
  test('accept positive number', () {
    const numberString = '1';
    const number = 1;
    final result = convertToInt(numberString);
    expect(result.left, number);
  });
  test('accept negative number', () {
    const numberString = '-1';
    const number = -1;
    final result = convertToInt(numberString);
    expect(result.left, number);
  });
  test('input invalid', () {
    const numberString = '1asdasd';
    final result = convertToInt(numberString);
    expect(result.right.message, inputInvalidErrorMessage);
  });
}
