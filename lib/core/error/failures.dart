
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const []]);

  @override
  List<Object> get props => [properties];
}


class ServerFailure extends Failure {

}

class CacheFailure extends Failure {

}

class GeneralFailure extends Failure {
  final String message;

  const GeneralFailure({required this.message});

}