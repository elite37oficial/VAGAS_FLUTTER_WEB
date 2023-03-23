part of '../blocs/register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final String company;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.company,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [company, email, password];
}
