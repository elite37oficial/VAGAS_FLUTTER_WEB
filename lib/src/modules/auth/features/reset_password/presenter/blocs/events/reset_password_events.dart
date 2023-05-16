part of '../blocs/reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class DoResetPasswordEvent extends ResetPasswordEvent {
  final String password;
  final String token;

  const DoResetPasswordEvent({
    required this.password,
    required this.token,
  });

  @override
  List<Object> get props => [password, token];
}

class CleanStateEvent extends ResetPasswordEvent {
  final ResetPasswordStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<ResetPasswordStates> get props => [state];
}
