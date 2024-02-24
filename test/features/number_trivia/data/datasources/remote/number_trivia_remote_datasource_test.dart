import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/api_response.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/remote/i_number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/remote/number_trivia_remote_data_source.dart';
import 'package:number_trivia/services/network_service/i_network_service.dart';
import 'package:number_trivia/services/network_service/network_service.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_datasource_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<NetworkService>(), MockSpec<NumberTriviaRemoteDatasource>()])
void main() {
  late INumberTriviaRemoteDataSource dataSource;
  late INetworkService networkService;

  setUp(() {
    networkService =
        GetIt.instance.registerSingleton<INetworkService>(MockNetworkService());
    dataSource = GetIt.instance
        .registerSingleton<INumberTriviaRemoteDataSource>(
            MockNumberTriviaRemoteDatasource());
  });

  group('getConcreteNumberTrivia', () {
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      when(networkService.get("http://numbersapi.com/1",
              headers: anyNamed('headers')))
          .thenAnswer((_) async =>
              ApiResponse(data: json.decode(fixture('trivia.json')),));
      // act
      await dataSource.getConcreteNumberTrivia(1);
      // assert
      verify(networkService.get('http://numbersapi.com/1',
          headers: {'Content-Type': 'application/json'}));
    });
  });
}
