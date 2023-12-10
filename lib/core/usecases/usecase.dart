import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';

///[Future].
mixin UseCases<T, Params> {
   Future<Either<Failure, T>> call(Params params);
}

///[Stream].
mixin StreamUseCases<T, Params> {
  Stream<Either<Failure, T>>  call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
