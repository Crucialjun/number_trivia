import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase with UseCases<NumberTrivia, int> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(int params) async {
    return await repository.getConcreteNumberTrivia(params);
  }
}
