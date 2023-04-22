part of '../blocs/login_bloc.dart';

enum UserRole { recrutador, admin }

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String? userId;
  final UserRole? role;

  LoginSuccessState({this.userId, this.role});
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}

class GetMySelfStateInitialState extends LoginState {}

class GetMySelfStateLoadingState extends LoginState {}

class GetMySelfStateSuccessState extends LoginState {
  final String? userId;
  final UserRole? role;

  GetMySelfStateSuccessState({this.userId, this.role});
}

class GetMySelfStateErrorState extends LoginState {
  final String message;

  GetMySelfStateErrorState({required this.message});
}
