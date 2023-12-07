import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/features/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/domain/entities/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase({required this.repository});

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}