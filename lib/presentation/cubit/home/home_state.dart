part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ErrorPersonalData extends HomeState {}

class SuccessPersonalData extends HomeState {}

class ErrorUpdatePersonalData extends HomeState {}

class SuccessUpdatePersonalData extends HomeState {}
