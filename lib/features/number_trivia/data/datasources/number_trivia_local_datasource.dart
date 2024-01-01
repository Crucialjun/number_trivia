import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

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