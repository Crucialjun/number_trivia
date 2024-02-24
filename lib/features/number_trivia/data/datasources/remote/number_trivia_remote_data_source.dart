import 'package:number_trivia/core/locator.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/remote/i_number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/services/network_service/i_network_service.dart';

class NumberTriviaRemoteDatasource implements INumberTriviaRemoteDataSource{
  final _networkService = locator<INetworkService>();

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async {
    var res =  await _networkService.get('http://numbersapi.com/$number');

    return NumberTriviaModel.fromJson(res.data);
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
  
}