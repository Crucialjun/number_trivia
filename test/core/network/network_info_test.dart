import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnection])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnection mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnection();
    networkInfoImpl =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasInternetAccess',
      () async {
        final tTHasConnectionFuture = Future.value(true);
        // arrange
        when(mockInternetConnectionChecker.hasInternetAccess)
            .thenAnswer((_) => tTHasConnectionFuture);
        // act
        final result = networkInfoImpl.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasInternetAccess);
        expect(result, tTHasConnectionFuture);
      },
    );
  });

  group('isNotConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasInternetAccess',
      () async {
        // arrange
        final tTHasConnectionFuture = Future.value(false);
        when(mockInternetConnectionChecker.hasInternetAccess)
            .thenAnswer((_) => tTHasConnectionFuture);
        // act
        final result = networkInfoImpl.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasInternetAccess);
        expect(result, tTHasConnectionFuture);
      },
    );
  });
}
