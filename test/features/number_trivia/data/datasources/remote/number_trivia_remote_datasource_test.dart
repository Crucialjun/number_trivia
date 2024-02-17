import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/annotations.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/remote/number_trivia_remote_datasource.dart';

import 'number_trivia_remote_datasource_test.mocks.dart';



@GenerateMocks([Dio])
void main() {

  late NumberTriviaRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = GetIt.instance<NumberTriviaRemoteDataSource>();
  });




 

 
}