part of '../blocs/reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class DoResetPasswordEvent extends ResetPasswordEvent {
  final String email;

  const DoResetPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class CleanStateEvent extends ResetPasswordEvent {
  final ResetPasswordStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<ResetPasswordStates> get props => [state];
}
