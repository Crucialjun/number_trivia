import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_imp.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_imp_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      localDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Test Trivia', number: tNumber);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        // act

        await repository.getConcreteNumberTrivia(tNumber);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verify(mockNumberTriviaRemoteDataSource
              .getConcreteNumberTrivia(tNumber));

          expect(result, equals(const Right(tNumberTrivia)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          // act
          await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verify(mockNumberTriviaRemoteDataSource
              .getConcreteNumberTrivia(tNumber));

          verify(mockNumberTriviaLocalDataSource
              .cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(tNumber))
              .thenThrow(ServerExceptions());
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verify(mockNumberTriviaRemoteDataSource
              .getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockNumberTriviaLocalDataSource);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
          expect(result, equals(const Right(tNumberTrivia)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheExceptions());

          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Test Trivia', number: 123);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        await repository.getRandomNumberTrivia();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getRandomNumberTrivia();

          // assert
          verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          await repository.getRandomNumberTrivia();
          // assert
          verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
          verify(mockNumberTriviaLocalDataSource
              .cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerExceptions());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
          verifyZeroInteractions(mockNumberTriviaLocalDataSource);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
          expect(result, equals(const Right(tNumberTrivia)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheExceptions());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
          verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
