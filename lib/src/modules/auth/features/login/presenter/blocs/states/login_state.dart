part of '../blocs/login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String userId;
  final String token;

  LoginSuccessState({required this.userId, required this.token});
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}
