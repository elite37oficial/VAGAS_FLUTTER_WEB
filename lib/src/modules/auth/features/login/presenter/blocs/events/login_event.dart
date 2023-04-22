part of '../blocs/login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const DoLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class DoGetMySelfEvent extends LoginEvent {
  final String userId;

  const DoGetMySelfEvent({
    required this.userId,
  });

  @override
  List<String> get props => [userId];
}

class CleanStateEvent extends LoginEvent {
  final LoginState state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<LoginState> get props => [state];
}
