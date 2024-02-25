part of 'number_bloc.dart';

sealed class NumberState extends Equatable {
  const NumberState();
  
  @override
  List<Object> get props => [];
}

final class NumberInitial extends NumberState {}
