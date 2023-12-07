import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  (Failure, NumberTrivia) getConcreteNumberTriviaRecords(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
  (Failure, NumberTrivia) getRandomNumberTriviaRecords();
}