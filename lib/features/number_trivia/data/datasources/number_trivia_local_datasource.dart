import 'dart:convert';

import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        "CACHED_NUMBER_TRIVIA", jsonEncode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString("CACHED_NUMBER_TRIVIA");
    if (jsonString == null) {
      throw CacheExceptions();
    }

    return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
  }
}
