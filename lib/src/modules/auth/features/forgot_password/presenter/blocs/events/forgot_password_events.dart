part of '../blocs/forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class DoForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;

  const DoForgotPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class CleanStateEvent extends ForgotPasswordEvent {
  final ForgotPasswordStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<ForgotPasswordStates> get props => [state];
}
