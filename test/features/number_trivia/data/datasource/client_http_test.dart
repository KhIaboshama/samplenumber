import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:samplenumber/core/constant/constant.dart';
import 'package:samplenumber/core/error/exception.dart';
import 'package:samplenumber/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'client_http_test.mocks.dart';

class MockHttpClient extends Mock implements Client {}

class MockResponse extends Mock implements Response {}

@GenerateMocks(<Type>[MockHttpClient, MockResponse])
void main() {
  late MockMockHttpClient client;
  late NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;

  setUp(() {
    client = MockMockHttpClient();
    numberTriviaRemoteDataSource =
        NumberTriviaRemoteDataSourceImpl(client: client);
  });

  test('success response', () async {
    const number = 1;
    final url = Uri.parse(
        numberTriviaRemoteDataSource.getNumberConcreteTriviaUrl(number));
    var body = await fixture('number_trivia.json');
    var bodyString = fixtureString('number_trivia.json');
    //
    var response = MockMockResponse();
    when(response.statusCode).thenReturn(200);
    when(response.body).thenReturn(body.toString());
    when(client.get(url, headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async => response);
    await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    verify(client.get(url, headers: {"Content-Type": "application/json"}));
    //
    var bodyStringResponse = MockMockResponse();
    when(bodyStringResponse.statusCode).thenReturn(200);
    when(bodyStringResponse.body).thenReturn(bodyString);
    when(client.get(url, headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async => bodyStringResponse);
    await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    verify(client.get(url, headers: {"Content-Type": "application/json"}));
  });
  test('failure response', () async {
    const number = 1;
    final url = Uri.parse(
        numberTriviaRemoteDataSource.getNumberConcreteTriviaUrl(number));
    //
    var response = MockMockResponse();
    when(response.statusCode).thenReturn(404);
    when(client.get(url, headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async => response);
    final result =
        await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    verify(client.get(url, headers: {"Content-Type": "application/json"}));
    expect(result.right,
        equals(const ServerException(message: somethingWentWrongErrorMessage)));
  });
}
