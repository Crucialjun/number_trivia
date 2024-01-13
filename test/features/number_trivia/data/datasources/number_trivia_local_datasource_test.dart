import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'number_trivia_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    test(
        "should return NumberTrivia from SharedPreferences when there is one in the cache",
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn('{"text": "test trivia", "number": 1}');
      // act
      final result = await dataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result.text, equals("test trivia"));
      expect(result.number, equals(1));
    });

    test("should throw a CacheException when there is not a cached value",
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
  });
}
