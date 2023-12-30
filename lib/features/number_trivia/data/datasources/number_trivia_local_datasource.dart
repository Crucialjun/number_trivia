import 'package:number_trivia/features/number_trivia/data/datasources/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Cache the [NumberTriviaModel] to the local database.
  ///
  /// Throws [CacheException] if the data is not cached.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}