
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
    numberTriviaRemoteDataSource =
        NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('response is success', () async {
    const number = 1;
    final url = Uri.parse(
        numberTriviaRemoteDataSource.getNumberConcreteTriviaUrl(number));
    when(mockHttpClient.get(url, headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async =>
        Response(fixture('number_trivia.json').toString(), 200));
    await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    verify(mockHttpClient.get(url, headers: {"Content-Type": "application/json"}));
  });
}
