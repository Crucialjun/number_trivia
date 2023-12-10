import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number:1,text:"test text");

  test('should be a subclass of NumberTrivia entity', () async {
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
}
