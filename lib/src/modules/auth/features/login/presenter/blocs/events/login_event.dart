import 'package:equatable/equatable.dart';

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

class GetMySelfEvent extends LoginEvent {
  final String userId;

  const GetMySelfEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
