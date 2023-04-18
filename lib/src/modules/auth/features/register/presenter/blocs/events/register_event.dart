part of '../blocs/register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String phone;
  final String profileID;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.name,
    required this.phone,
    required this.profileID,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, phone, profileID, email, password];
}
