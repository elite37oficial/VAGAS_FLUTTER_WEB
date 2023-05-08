part of '../blocs/forgot_password_bloc.dart';

abstract class ForgotPasswordStates {}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordLoadingState extends ForgotPasswordStates {}

class ForgotPasswordSuccessState extends ForgotPasswordStates {
  final String message;

  ForgotPasswordSuccessState({required this.message});
}

class ForgotPasswordErrorState extends ForgotPasswordStates {
  final String message;

  ForgotPasswordErrorState({required this.message});
}
