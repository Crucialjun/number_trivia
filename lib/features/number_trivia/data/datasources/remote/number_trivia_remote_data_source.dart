import 'package:number_trivia/features/number_trivia/data/datasources/remote/i_number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaRemoteDatasource implements INumberTriviaRemoteDataSource{
  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
  
}