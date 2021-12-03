part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String message;

  AuthFailedState({this.message});
}
